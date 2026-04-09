## CollectibleManager - Global tracker for collectibles
## Mantiene el conteo de coleccionables recogidos
extends Node

# Signal emitted when a collectible is picked up
signal collectible_picked(total_count: int)

# Total collectibles picked
var total_collectibles: int = 0

func _ready() -> void:
	print("CollectibleManager initialized - Total collectibles: ", total_collectibles)

func pick_collectible() -> void:
	"""Called when a collectible is picked up"""
	total_collectibles += 1
	print("Collectible picked! Total: ", total_collectibles)
	collectible_picked.emit(total_collectibles)

func get_total() -> int:
	"""Get the total number of collectibles picked"""
	return total_collectibles

func reset() -> void:
	"""Reset the collectible count (useful for level restarts)"""
	total_collectibles = 0
	print("Collectibles reset")
