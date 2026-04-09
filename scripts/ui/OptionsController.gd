## Options Controller - Handle settings menu
extends Control

@onready var volume_slider = $OptionsPanel/VBoxContainer/VolumeContainer/VolumeSlider
@onready var back_button = $OptionsPanel/VBoxContainer/BackButton

func _ready() -> void:
	# Set slider initial value based on current volume
	if AudioServer.get_bus_count() > 0:
		var master_bus_index = AudioServer.get_bus_index("Master")
		var current_db = AudioServer.get_bus_volume_db(master_bus_index)
		# Convert dB to linear scale (0-1) and then to slider range (0-100)
		volume_slider.value = db_to_linear(current_db) * 100.0
	else:
		volume_slider.value = 80.0
	
	volume_slider.value_changed.connect(_on_volume_changed)
	back_button.pressed.connect(_on_back_pressed)
	
	# Add hover animations to back button
	back_button.mouse_entered.connect(_on_back_button_hover.bindv([true]))
	back_button.mouse_exited.connect(_on_back_button_hover.bindv([false]))

func _on_volume_changed(value: float) -> void:
	# Convert slider value (0-100) to dB and apply to Master bus
	if AudioServer.get_bus_count() > 0:
		var master_bus_index = AudioServer.get_bus_index("Master")
		var db_value = linear_to_db(value / 100.0)
		AudioServer.set_bus_volume_db(master_bus_index, db_value)

func _on_back_button_hover(is_hovering: bool) -> void:
	"""Handle back button hover animation"""
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	
	if is_hovering:
		tween.tween_property(back_button, "scale", Vector2(1.2, 1.2), 0.3)
		var color_tween = create_tween()
		color_tween.set_trans(Tween.TRANS_QUAD)
		color_tween.set_ease(Tween.EASE_OUT)
		color_tween.tween_property(back_button, "modulate", Color(0.2, 0.8, 1, 1), 0.3)
	else:
		tween.tween_property(back_button, "scale", Vector2(1, 1), 0.3)
		var color_tween = create_tween()
		color_tween.set_trans(Tween.TRANS_QUAD)
		color_tween.set_ease(Tween.EASE_OUT)
		color_tween.tween_property(back_button, "modulate", Color(1, 1, 1, 1), 0.3)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/Menu.tscn")
