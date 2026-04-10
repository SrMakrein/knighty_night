## PortalController - Controla la activación del portal basándose en coleccionables
extends Node3D

class_name PortalController

@export var required_collectibles: int = 3
@export var portal_animation_name: String = "portal_up"

var portal_node: Node3D
var animation_player: AnimationPlayer
var door_collision_shape: CollisionShape3D
var is_activated: bool = false

func _ready() -> void:
	print("\n=== PortalController _ready() ===")
	print("Configuration - Required collectibles: ", required_collectibles)
	
	# Buscar el nodo del portal
	portal_node = get_node_or_null("portal")
	
	if not portal_node:
		portal_node = get_child(0) if get_child_count() > 0 else null
	
	if not portal_node:
		print("ERROR: Portal node not found")
		return
	
	print("Portal node found: ", portal_node.name)
	
	# Buscar AnimationPlayer del portal
	var skeleton = portal_node.find_child("Skeleton3D", true, false) as Skeleton3D
	if skeleton:
		animation_player = skeleton.find_child("AnimationPlayer", true, false) as AnimationPlayer
		if animation_player:
			print("AnimationPlayer found at: ", animation_player.get_path())
		else:
			print("WARNING: AnimationPlayer not found under Skeleton3D")
	else:
		print("WARNING: Skeleton3D not found")
	
	# Si no encontró, buscar bajo portal directamente
	if not animation_player:
		var all_anim_players = []
		_find_all_animation_players(portal_node, all_anim_players)
		print("Found ", all_anim_players.size(), " AnimationPlayers in total")
		for i in range(all_anim_players.size()):
			var ap = all_anim_players[i] as AnimationPlayer
			print("  [", i, "] AnimationPlayer at: ", ap.get_path())
			var anims = ap.get_animation_list()
			print("      Animations: ", anims)
		
		if all_anim_players.size() > 0:
			animation_player = all_anim_players[0] as AnimationPlayer
	
	# Buscar DoorPhysics y su CollisionShape3D
	var door_physics = portal_node.find_child("DoorPhysics", true, false) as Node3D
	if door_physics:
		print("DoorPhysics node found at: ", door_physics.get_path())
		door_collision_shape = door_physics.find_child("CollisionShape3D", true, false) as CollisionShape3D
		if door_collision_shape:
			print("Door CollisionShape3D found at: ", door_collision_shape.get_path())
			print("Current collision shape disabled state: ", door_collision_shape.disabled)
		else:
			print("ERROR: CollisionShape3D not found under DoorPhysics")
	else:
		print("ERROR: DoorPhysics node not found")
	
	if animation_player:
		# Conectar señal de animación terminada
		if not animation_player.animation_finished.is_connected(_on_animation_finished):
			animation_player.animation_finished.connect(_on_animation_finished)
		# Mostrar animaciones disponibles
		var anims = animation_player.get_animation_list()
		print("AnimationPlayer available animations: ", anims)
	else:
		print("ERROR: AnimationPlayer not found")
	
	# Conectar la señal del CollectibleManager
	await get_tree().process_frame
	
	if CollectibleManager:
		print("CollectibleManager found, connecting signal")
		if not CollectibleManager.collectible_picked.is_connected(_on_collectible_picked):
			CollectibleManager.collectible_picked.connect(_on_collectible_picked)
	else:
		print("ERROR: CollectibleManager not found")
	
	# Verificar si ya se cumple la condición al iniciar
	check_activation()
	print("=== PortalController _ready() complete ===\n")

func _find_all_animation_players(node: Node, result: Array) -> void:
	"""Busca todos los AnimationPlayers en el árbol"""
	if node is AnimationPlayer:
		result.append(node)
	for child in node.get_children():
		_find_all_animation_players(child, result)

func _print_portal_structure(node: Node, indent: int) -> void:
	"""Debug function to print the portal node structure"""
	var indent_str = ""
	for i in range(indent):
		indent_str += "  "
	print(indent_str + "- " + node.name + " (" + node.get_class() + ")")
	for child in node.get_children():
		_print_portal_structure(child, indent + 1)

func _print_animations() -> void:
	"""Debug function to print available animations"""
	if animation_player:
		var animations = animation_player.get_animation_list()
		print("Available animations: ", animations)
		if not portal_animation_name in animations:
			print("WARNING: Animation '", portal_animation_name, "' not found!")
	else:
		print("ERROR: animation_player is null")

func _on_collectible_picked(_total_count: int) -> void:
	"""Llamado cuando se recoge un coleccionable"""
	check_activation()

func _on_animation_finished(anim_name: StringName) -> void:
	"""Llamado cuando termina cualquier animación"""
	print("Animation finished: ", anim_name)
	
	# Si es la animación del portal, desactivar el colider
	if anim_name == portal_animation_name:
		print("Portal animation '", portal_animation_name, "' finished - Disabling door collider")
		
		if door_collision_shape == null:
			print("ERROR: door_collision_shape is null")
			return
		
		if not is_instance_valid(door_collision_shape):
			print("ERROR: door_collision_shape is not valid")
			# Intentar buscar nuevamente
			var door_physics = portal_node.find_child("DoorPhysics", true, false) as Node3D
			if door_physics:
				door_collision_shape = door_physics.find_child("CollisionShape3D", true, false) as CollisionShape3D
			else:
				print("ERROR: Cannot find DoorPhysics again")
				return
		
		if is_instance_valid(door_collision_shape):
			door_collision_shape.disabled = true
			print("Door collider disabled successfully - Player can now pass")
		else:
			print("ERROR: door_collision_shape still invalid")

func check_activation() -> void:
	"""Verifica si el portal debe activarse"""
	if is_activated:
		return
	
	var current_collectibles = CollectibleManager.get_total()
	print("Checking portal activation - Current collectibles: ", current_collectibles, " / ", required_collectibles)
	
	if current_collectibles >= required_collectibles:
		activate_portal()

func activate_portal() -> void:
	"""Activa el portal reproduciendo la animación"""
	is_activated = true
	print("\n=== PORTAL ACTIVATION ===")
	print("Playing portal animation...")
	
	# Reproducir la animación del portal
	if animation_player and animation_player.has_animation(portal_animation_name):
		print("Playing animation: ", portal_animation_name)
		animation_player.play(portal_animation_name)
	else:
		print("ERROR: Cannot play portal animation - AnimationPlayer or animation not found")
	
	print("=== PORTAL ACTIVATION COMPLETE ===\n")
