## Options Menu Pausa Controller - Volume control for pause menu
## Funciona identicamente al menú de opciones del menú principal
## Permite cambiar volumen incluso durante la pausa
## Oculta la interacción del menú de pausa mientras está abierto
extends Control

@onready var volume_slider = $OptionsPanel/VBoxContainer/VolumeContainer/VolumeSlider
@onready var back_button = $OptionsPanel/VBoxContainer/BackButton

# Animation settings
var button_hover_scale: float = 1.2
var button_normal_color: Color = Color(1, 1, 1, 1)
var button_hover_color: Color = Color(0.2, 0.8, 1, 1)
var animation_speed: float = 0.3

# Track mouse click state
var mouse_pressed_last_frame: bool = false
var slider_dragging: bool = false
var click_timer: Timer

# Reference to pause menu to hide it
var pause_menu_parent = null

func _ready() -> void:
	print("OptionsMenuPausa initialized")
	
	# Get reference to parent PauseMenu (now direct parent)
	pause_menu_parent = get_parent()
	print("Pause menu parent: ", pause_menu_parent.name if pause_menu_parent else "None")
	
	# Verify back button exists
	if not back_button:
		print("ERROR: Back button not found!")
	else:
		print("Back button found: ", back_button.name)
		# Connect back button pressed signal
		back_button.pressed.connect(_on_back_pressed)
		print("Back button signal connected")
	
	# Set slider initial value based on current volume
	if AudioServer.get_bus_count() > 0:
		var master_bus_index = AudioServer.get_bus_index("Master")
		var current_db = AudioServer.get_bus_volume_db(master_bus_index)
		# Convert dB to linear scale (0-1) and then to slider range (0-100)
		volume_slider.value = db_to_linear(current_db) * 100.0
	else:
		volume_slider.value = 80.0
	
	# Connect slider value changed
	volume_slider.value_changed.connect(_on_volume_changed)
	
	# Connect back button hover
	if back_button:
		back_button.mouse_entered.connect(_on_button_hover.bind(back_button, true))
		back_button.mouse_exited.connect(_on_button_hover.bind(back_button, false))
	
	# Create a Timer for slider interaction (runs even when paused) - but now we'll use button signal
	click_timer = Timer.new()
	click_timer.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(click_timer)
	click_timer.wait_time = 0.01
	click_timer.timeout.connect(_on_interaction_timer_timeout)
	click_timer.start()
	
	# Pause the parent PauseMenu's click detection
	if pause_menu_parent and pause_menu_parent.has_method("pause_interaction"):
		pause_menu_parent.pause_interaction()
	
	print("OptionsMenuPausa ready")

func _input(event: InputEvent) -> void:
	# Go back with ESC
	if event.is_action_pressed("ui_cancel"):
		_on_back_pressed()
		get_tree().root.set_input_as_handled()
		return
	
	# Do NOT consume mouse button events - let them reach buttons!
	# Only consume mouse motion to prevent game input
	if event is InputEventMouseMotion:
		get_tree().root.set_input_as_handled()

func _on_button_hover(button: Button, is_hovering: bool) -> void:
	"""Handle button hover animation"""
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	
	if is_hovering:
		tween.tween_property(button, "scale", Vector2(button_hover_scale, button_hover_scale), animation_speed)
		var color_tween = create_tween()
		color_tween.set_trans(Tween.TRANS_QUAD)
		color_tween.set_ease(Tween.EASE_OUT)
		color_tween.tween_property(button, "modulate", button_hover_color, animation_speed)
	else:
		tween.tween_property(button, "scale", Vector2(1, 1), animation_speed)
		var color_tween = create_tween()
		color_tween.set_trans(Tween.TRANS_QUAD)
		color_tween.set_ease(Tween.EASE_OUT)
		color_tween.tween_property(button, "modulate", button_normal_color, animation_speed)

func _on_interaction_timer_timeout() -> void:
	"""Timer callback for interaction detection and slider dragging"""
	var mouse_pos = get_global_mouse_position()
	
	# Check if mouse is over slider and dragging
	if volume_slider.get_global_rect().has_point(mouse_pos):
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			slider_dragging = true
			# Calculate slider value from mouse position
			var slider_rect = volume_slider.get_global_rect()
			var relative_x = mouse_pos.x - slider_rect.position.x
			var slider_percent = clamp(relative_x / slider_rect.size.x, 0.0, 1.0)
			var new_value = slider_percent * (volume_slider.max_value - volume_slider.min_value) + volume_slider.min_value
			volume_slider.value = new_value
			print("Slider dragging: ", new_value)
		else:
			slider_dragging = false
	else:
		slider_dragging = false
	
	# Check for back button clicks
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not mouse_pressed_last_frame:
			if back_button.get_global_rect().has_point(mouse_pos):
				_on_back_pressed()
		
		mouse_pressed_last_frame = true
	else:
		mouse_pressed_last_frame = false

func _on_volume_changed(value: float) -> void:
	"""Update volume when slider changes"""
	print("Volume changed to: ", value)
	# Convert slider value (0-100) to dB and apply to Master bus
	if AudioServer.get_bus_count() > 0:
		var master_bus_index = AudioServer.get_bus_index("Master")
		var db_value = linear_to_db(value / 100.0)
		AudioServer.set_bus_volume_db(master_bus_index, db_value)
		print("Audio bus volume set to dB: ", db_value)

func _on_back_pressed() -> void:
	"""Go back to pause menu"""
	print("Back button pressed - returning to pause menu")
	
	# Show pause menu panel again
	var menu_panel = pause_menu_parent.get_node_or_null("MenuPanel")
	if menu_panel:
		menu_panel.visible = true
		print("PauseMenu panel shown")
	
	# Resume the pause menu's click timer
	if pause_menu_parent and pause_menu_parent.has_method("resume_interaction"):
		pause_menu_parent.resume_interaction()
	
	# Re-enable pause menu input
	if pause_menu_parent and pause_menu_parent is Control:
		pause_menu_parent.mouse_filter = Control.MOUSE_FILTER_STOP
		print("PauseMenu input re-enabled")
	
	queue_free()
