## Menu Controller - Main menu navigation with animations
extends Control

@onready var play_button = $MenuPanel/VBoxContainer/PlayButton
@onready var options_button = $MenuPanel/VBoxContainer/OptionsButton
@onready var quit_button = $MenuPanel/VBoxContainer/QuitButton

# Animation settings
var button_hover_scale: float = 1.2
var button_normal_color: Color = Color(1, 1, 1, 1)
var button_hover_color: Color = Color(0.2, 0.8, 1, 1)
var animation_speed: float = 0.3

func _ready() -> void:
	# Setup buttons as labels without button appearance
	for button in [play_button, options_button, quit_button]:
		button.pressed.connect(_on_button_pressed.bind(button))
		button.mouse_entered.connect(_on_button_hover.bind(button, true))
		button.mouse_exited.connect(_on_button_hover.bind(button, false))
	
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

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

func _on_button_pressed(button: Button) -> void:
	"""Click animation for buttons"""
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(button, "scale", Vector2(0.95, 0.95), 0.1)
	tween.tween_property(button, "scale", Vector2(button_hover_scale, button_hover_scale), 0.1)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/main.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/OptionsMenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
