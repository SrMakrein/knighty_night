## Main Level Manager - Sets up the main scene with platforms and environment
extends Node3D

class_name MainLevel

func _ready() -> void:
	# Game initialized, everything should be playable
	print("Level loaded successfully!")

func _process(_delta: float) -> void:
	# Check if player fell off the world
	var player = get_node_or_null("Player")
	if player and player.global_position.y < -10:
		# Reset player position
		player.global_position = Vector3(0, 2, 0)
		player.velocity = Vector3.ZERO
