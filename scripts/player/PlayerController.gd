## Player Controller - Handles movement, jumping, gravity, and animation
## Uses CharacterBody3D for physics
extends CharacterBody3D

class_name PlayerController

# Movement parameters
@export var max_walk_speed: float = 7.0
@export var max_run_speed: float = 11.0
@export var acceleration: float = 30.0
@export var friction: float = 25.0
@export var gravity: float = 15.0
@export var jump_force: float = 8.0

# State
var current_speed: float = 0.0
var is_jumping: bool = false
var is_grounded: bool = false

# References
@onready var animation_player: AnimationPlayer = $KnightModel/AnimationPlayer
@onready var camera_controller = get_node_or_null("CameraController")

# Pause menu scene
var pause_menu_scene = preload("res://scenes/ui/PauseMenu.tscn")

func _ready() -> void:
	# Add to player group for detection by collectibles and other systems
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Check for pause input
	if Input.is_action_just_pressed("ui_cancel"):
		_open_pause_menu()
		return
	
	# Get input
	var input_direction = get_input_direction()
	var is_running = Input.is_action_pressed("run")
	
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
		is_grounded = false
	else:
		is_grounded = true
		# Reset vertical velocity when grounded
		if velocity.y < 0:
			velocity.y = 0
	
	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true
	
	# Calculate target speed based on input
	var target_speed = 0.0
	if input_direction.length() > 0:
		target_speed = max_run_speed if is_running else max_walk_speed
	
	# Apply movement in camera space - ensure move_direction is always Vector3
	var move_direction = Vector3(input_direction.x, 0, input_direction.y)
	if camera_controller:
		move_direction = apply_camera_relative_movement(input_direction)
	
	# Apply acceleration/friction
	if move_direction.length() > 0:
		current_speed = move_toward(current_speed, target_speed, acceleration * delta)
		# Rotate only the model (KnightModel), not the CharacterBody3D
		# This keeps camera and controls fixed relative to camera
		if move_direction.length() > 0.01:
			var target_angle = atan2(move_direction.x, move_direction.z)
			# Compensate for the initial 90° rotation of the model
			target_angle -= PI / 2
			var knight_model = get_node_or_null("KnightModel")
			if knight_model:
				# Calculate shortest rotation path
				var current_angle = knight_model.rotation.y
				var angle_diff = target_angle - current_angle
				
				# Normalize angle difference to shortest path (-PI to PI)
				while angle_diff > PI:
					angle_diff -= TAU
				while angle_diff < -PI:
					angle_diff += TAU
				
				# Apply the shortest rotation
				knight_model.rotation.y = move_toward(current_angle, current_angle + angle_diff, deg_to_rad(720) * delta)
	else:
		# Stop immediately without delay when input is released
		current_speed = 0.0
	
	# Apply movement
	if move_direction.length() > 0:
		velocity.x = move_direction.x * current_speed
		velocity.z = move_direction.z * current_speed
	else:
		# Stop immediately without smoothing
		velocity.x = 0.0
		velocity.z = 0.0
	
	# Move the character
	move_and_slide()
	
	# Update animation
	update_animation(input_direction.length(), is_grounded)

func get_input_direction() -> Vector2:
	"""Get input direction from keyboard/controller"""
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_forward"):
		direction.y += 1
	if Input.is_action_pressed("move_backward"):
		direction.y -= 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	return direction.normalized()

func apply_camera_relative_movement(input_direction: Vector2) -> Vector3:
	"""Convert input direction to camera-relative world direction based on camera yaw"""
	if camera_controller == null:
		return Vector3(input_direction.x, 0, input_direction.y)
	
	# Use camera's yaw angle to determine movement direction
	# The camera yaw directly defines where "forward" is
	var camera_yaw = camera_controller.yaw
	var yaw_rad = deg_to_rad(camera_yaw)
	
	# Calculate forward and right vectors based on camera yaw
	var camera_forward = Vector3(-sin(yaw_rad), 0, -cos(yaw_rad))
	var camera_right = Vector3(cos(yaw_rad), 0, -sin(yaw_rad))
	
	# Combine input with camera directions
	var move_direction = (camera_forward * input_direction.y + camera_right * input_direction.x)
	
	# Only normalize if there's movement
	if move_direction.length() > 0.0:
		move_direction = move_direction.normalized()
	
	return move_direction

func update_animation(input_magnitude: float, ground_detected: bool) -> void:
	"""Update animation state based on movement"""
	if animation_player == null:
		return
	
	var state = "idle"
	
	# Prioridad: Salto > Movimiento > Idle
	if not ground_detected:
		# Saltando
		state = "jump"
	elif input_magnitude > 0.1:
		# Moviéndose
		state = "walk"
	else:
		# No haciendo nada
		state = "idle"
	
	# Obtener lista de animaciones disponibles
	var available_anims = animation_player.get_animation_list()
	
	# Mapear estados a nombres de animación reales
	var anim_map = {
		"idle": "Idle",
		"walk": "Walk",
		"jump": "Jump"
	}
	
	# Auto-detectar animaciones disponibles
	for key in anim_map.keys():
		if anim_map[key] not in available_anims:
			# Intentar variaciones
			for anim in available_anims:
				if anim.to_lower() == key:
					anim_map[key] = anim
					break
	
	# Reproducir la animación correspondiente
	var anim_name = anim_map.get(state, state)
	if anim_name in available_anims:
		if animation_player.current_animation != anim_name:
			animation_player.play(anim_name)

func get_ground_detection() -> bool:
	"""Returns true if player is on ground"""
	return is_on_floor()
func _open_pause_menu() -> void:
	"""Open the pause menu"""
	var pause_menu = pause_menu_scene.instantiate()
	get_tree().root.add_child(pause_menu)
