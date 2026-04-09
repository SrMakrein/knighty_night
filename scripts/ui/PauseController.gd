## Pause Controller - Handle pause menu during gameplay
extends Control

class_name PauseController

@onready var continuar_button = $MenuPanel/VBoxContainer/ContinuarButton
@onready var options_button = $MenuPanel/VBoxContainer/OptionsButton
@onready var menu_principal_button = $MenuPanel/VBoxContainer/MenuPrincipalButton

# Animation settings
var button_hover_scale: float = 1.2
var button_normal_color: Color = Color(1, 1, 1, 1)
var button_hover_color: Color = Color(0.2, 0.8, 1, 1)
var animation_speed: float = 0.3

# Track if we should handle input
var should_handle_input: bool = true

func _ready() -> void:
	print("=== PauseMenu _ready() ===")
	print("Process mode: ", process_mode)
	print("Visible: ", visible)
	print("Mouse filter: ", mouse_filter)
	print("Continuar button: ", continuar_button)
	print("Continuar button mouse_filter: ", continuar_button.mouse_filter if continuar_button else "NULL")
	print("Continuar button can_focus: ", continuar_button.focus_mode if continuar_button else "NULL")
	
	# Verify buttons exist and are visible
	if not continuar_button:
		print("ERROR: Continuar button not found!")
	if not options_button:
		print("ERROR: Options button not found!")
	if not menu_principal_button:
		print("ERROR: Menu principal button not found!")
	
	# Connect button clicks directly
	if continuar_button:
		continuar_button.pressed.connect(_on_continuar_pressed)
		print("Continuar button signal connected")
	if options_button:
		options_button.pressed.connect(_on_options_pressed)
		print("Options button signal connected")
	if menu_principal_button:
		menu_principal_button.pressed.connect(_on_menu_principal_pressed)
		print("Menu principal button signal connected")
	
	# Connect hover animations
	if continuar_button:
		continuar_button.mouse_entered.connect(_on_button_hover.bind(continuar_button, true))
		continuar_button.mouse_exited.connect(_on_button_hover.bind(continuar_button, false))
	
	if options_button:
		options_button.mouse_entered.connect(_on_button_hover.bind(options_button, true))
		options_button.mouse_exited.connect(_on_button_hover.bind(options_button, false))
	
	if menu_principal_button:
		menu_principal_button.mouse_entered.connect(_on_button_hover.bind(menu_principal_button, true))
		menu_principal_button.mouse_exited.connect(_on_button_hover.bind(menu_principal_button, false))
	
	# Pause the game
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print("Game paused, mouse visible")
	print("=== PauseMenu _ready() complete ===")

func pause_interaction() -> void:
	"""Pause input handling"""
	should_handle_input = false
	print("PauseMenu input handling paused")

func resume_interaction() -> void:
	"""Resume input handling"""
	should_handle_input = true
	print("PauseMenu input handling resumed")

func _gui_input(event: InputEvent) -> void:
	"""Handle GUI input - DON'T consume events, let buttons process them first"""
	if not should_handle_input:
		return
	
	# Debug mouse events
	if event is InputEventMouseButton:
		print("GUI INPUT: MouseButton event detected at position: ", event.position)
		print("  Button index: ", event.button_index)
		print("  Pressed: ", event.pressed)
		
		# Check which button was clicked
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var global_pos = get_global_mouse_position()
			print("  Global mouse position: ", global_pos)
			
			if continuar_button and continuar_button.get_global_rect().has_point(global_pos):
				print("  -> Continuar button clicked!")
			if options_button and options_button.get_global_rect().has_point(global_pos):
				print("  -> Options button clicked!")
			if menu_principal_button and menu_principal_button.get_global_rect().has_point(global_pos):
				print("  -> Menu principal button clicked!")
	
	# IMPORTANT: DO NOT consume mouse events - let buttons handle them!
	# This was preventing button.pressed signals from being emitted
	# Only consume motion events to prevent camera movement during pause
	if event is InputEventMouseMotion:
		accept_event()

func _input(event: InputEvent) -> void:
	# Resume with ESC
	if event.is_action_pressed("ui_cancel"):
		print("ESC pressed - resuming")
		_on_continuar_pressed()
		get_tree().root.set_input_as_handled()
		return
	
	# Debug all input events
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("INPUT EVENT: MouseButton LEFT CLICK at global position: ", get_global_mouse_position())
		var global_pos = get_global_mouse_position()
		
		# Manually check button rectangles
		if continuar_button:
			var btn_rect = continuar_button.get_global_rect()
			print("  Continuar rect: ", btn_rect)
			if btn_rect.has_point(global_pos):
				print("  -> Click is within Continuar button bounds!")
		
		if options_button:
			var btn_rect = options_button.get_global_rect()
			print("  Options rect: ", btn_rect)
			if btn_rect.has_point(global_pos):
				print("  -> Click is within Options button bounds!")
		
		if menu_principal_button:
			var btn_rect = menu_principal_button.get_global_rect()
			print("  Menu principal rect: ", btn_rect)
			if btn_rect.has_point(global_pos):
				print("  -> Click is within Menu principal button bounds!")
	
	# IMPORTANT: Do NOT consume mouse button events - let buttons handle them!
	# Only consume mouse motion to prevent game input
	if event is InputEventMouseMotion:
		get_tree().root.set_input_as_handled()

func _on_button_hover(button: Button, is_hovering: bool) -> void:
	"""Handle button hover animation"""
	print("Hover: ", button.name, " = ", is_hovering)
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

func _on_continuar_pressed() -> void:
	"""Resume game"""
	print("CLICK: Continuar button pressed!")
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()

func _on_options_pressed() -> void:
	"""Go to options menu"""
	print("CLICK: Options button pressed!")
	# Hide this menu's panel while options is open
	$MenuPanel.visible = false
	print("PauseMenu panel hidden")
	
	# Pause the click timer to prevent interaction
	pause_interaction()
	
	# Disable this menu's input to prevent interaction while options is open
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	print("PauseMenu input disabled")
	
	# Instantiate options menu as overlay (add as child of PauseMenu)
	var options_menu = preload("res://scenes/ui/OptionsMenuPausa.tscn").instantiate()
	add_child(options_menu)

func _on_menu_principal_pressed() -> void:
	"""Go to main menu and discard current scene"""
	print("CLICK: Menu Principal button pressed!")
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/ui/Menu.tscn")
	# Ensure pause menu is cleaned up
	queue_free()
