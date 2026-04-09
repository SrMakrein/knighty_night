## Camera Controller - Handles third-person camera following and input
extends Node3D

class_name CameraController

# Camera parameters
@export var distance: float = 5.0
@export var height: float = 1.8
@export var mouse_sensitivity: float = 0.1
@export var gamepad_sensitivity: float = 3.0
@export var min_pitch: float = -60.0
@export var max_pitch: float = 60.0
@export var orbit_speed: float = 360.0

# State
var pitch: float = 20.0
var yaw: float = 0.0

# References
@onready var camera_3d: Camera3D = $Camera3D
var player: Node3D

func _ready() -> void:
	player = get_parent()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Mouse movement for camera rotation
		yaw -= event.relative.x * mouse_sensitivity
		pitch = clamp(pitch + event.relative.y * mouse_sensitivity, min_pitch, max_pitch)
		get_tree().root.set_input_as_handled()
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP or event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			get_tree().root.set_input_as_handled()

func _process(delta: float) -> void:
	# Get gamepad camera input
	var camera_input = Vector2.ZERO
	
	if Input.is_action_pressed("camera_right"):
		camera_input.x += Input.get_action_strength("camera_right")
	if Input.is_action_pressed("camera_left"):
		camera_input.x -= Input.get_action_strength("camera_left")
	if Input.is_action_pressed("camera_up"):
		camera_input.y += Input.get_action_strength("camera_up")
	if Input.is_action_pressed("camera_down"):
		camera_input.y -= Input.get_action_strength("camera_down")
	
	# Update camera angles with gamepad
	yaw += camera_input.x * gamepad_sensitivity * orbit_speed * delta
	pitch = clamp(pitch - camera_input.y * gamepad_sensitivity * orbit_speed * delta, min_pitch, max_pitch)
	
	# Unlock mouse with ESC
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Calculate desired camera position
	var desired_position = calculate_camera_position()
	
	# Set camera position directly
	camera_3d.global_position = desired_position
	
	# Look at player head
	var look_at_pos = player.global_position + Vector3(0, height, 0)
	camera_3d.look_at(look_at_pos, Vector3.UP)

func calculate_camera_position() -> Vector3:
	"""Calculate the desired camera position based on angles and distance"""
	var player_pos = player.global_position
	
	# Convert spherical to cartesian coordinates
	var horizontal_distance = distance * cos(deg_to_rad(pitch))
	var vertical_offset = distance * sin(deg_to_rad(pitch)) + height
	
	var yaw_rad = deg_to_rad(yaw)
	var x = player_pos.x + horizontal_distance * sin(yaw_rad)
	var y = player_pos.y + vertical_offset
	var z = player_pos.z + horizontal_distance * cos(yaw_rad)
	
	return Vector3(x, y, z)

func get_camera_forward() -> Vector3:
	"""Get the forward direction the camera is looking"""
	return -camera_3d.global_transform.basis.z

func get_camera_right() -> Vector3:
	"""Get the right direction relative to camera"""
	return camera_3d.global_transform.basis.x
