## HUD Controller - Displays game information
extends CanvasLayer

class_name HUDController

@onready var collectibles_label = Label.new()

func _ready() -> void:
	# Create and configure collectibles label
	collectibles_label.text = "Collectibles: 0"
	collectibles_label.anchor_left = 0.98
	collectibles_label.anchor_top = 0.02
	collectibles_label.anchor_right = 1.0
	collectibles_label.anchor_bottom = 0.1
	collectibles_label.offset_left = -200
	collectibles_label.offset_right = -10
	collectibles_label.offset_top = 10
	collectibles_label.offset_bottom = 50
	collectibles_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	collectibles_label.add_theme_font_size_override("font_size", 24)
	
	add_child(collectibles_label)
	
	# Connect to CollectibleManager signal
	CollectibleManager.collectible_picked.connect(_on_collectible_picked)
	
	# Initialize with current count
	_update_collectibles_label(CollectibleManager.get_total())
	
	print("HUD initialized")

func _on_collectible_picked(total_count: int) -> void:
	"""Called when a collectible is picked up"""
	_update_collectibles_label(total_count)

func _update_collectibles_label(count: int) -> void:
	"""Update the collectibles label with the current count"""
	collectibles_label.text = "Collectibles: " + str(count)
	print("HUD updated - Collectibles: ", count)
