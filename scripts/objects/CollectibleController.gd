## CollectibleController - Handles collectible pickup and animation
extends Area3D

class_name CollectibleController

@export var float_speed: float = 2.0
@export var rotation_speed: float = 2.0
@export var float_height: float = 0.3

var start_position: Vector3
var time_elapsed: float = 0.0
var is_collected: bool = false

func _ready() -> void:
	start_position = global_position
	print("Collectible spawned at: ", start_position)
	
	# Connect area detection - Area3D can detect both Area3D and PhysicsBody3D
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	if is_collected:
		return
	
	# Floating animation
	time_elapsed += delta
	var new_y = start_position.y + sin(time_elapsed * float_speed) * float_height
	global_position.y = new_y
	
	# Rotation animation
	rotate_y(rotation_speed * delta)

func _on_area_entered(area: Area3D) -> void:
	"""Called when another Area3D enters"""
	if is_collected:
		return
	
	print("Area entered: ", area.name)
	if area.is_in_group("player"):
		print("Player detected via area_entered!")
		pick_up()

func _on_body_entered(body: Node3D) -> void:
	"""Called when a PhysicsBody3D (like CharacterBody3D) enters"""
	if is_collected:
		return
	
	print("Body entered: ", body.name, " | Type: ", body.get_class())
	
	# Check if it's the player
	if body.is_in_group("player"):
		print("Player detected via body_entered!")
		pick_up()
	elif body.name.contains("Player"):
		print("Player detected via name!")
		pick_up()

func pick_up() -> void:
	"""Handle collectible pickup"""
	if is_collected:
		return
	
	is_collected = true
	print("Collectible picked up!")
	
	# Notify the global manager
	CollectibleManager.pick_collectible()
	
	# Remove the collectible from the scene
	queue_free()
