## EnemyController - Controla el comportamiento del enemigo
extends Node3D

class_name EnemyController

@export var enemy_height: float = 1.0
@export var crush_scale: float = 0.1
@export var crush_duration: float = 0.3
@export var destroy_delay: float = 0.5
@export var bounce_force: float = 12.0
@export var smoke_particle_count: int = 30
@export var smoke_lifetime: float = 1.5
@export var smoke_speed: float = 3.0

var is_crushed: bool = false
var area_3d: Area3D
var mesh_instance: MeshInstance3D
var spawn_position: Vector3
var smoke_particles: CPUParticles3D

func _ready() -> void:
	print("Enemy spawned at: ", global_position)
	
	# Guardar la posición global para usarla después
	spawn_position = global_position
	
	# Buscar el Area3D para detectar colisiones
	area_3d = find_child("Area3D", true, false) as Area3D
	
	# Buscar el MeshInstance3D para la animación visual
	mesh_instance = find_child("MeshInstance3D", true, false) as MeshInstance3D
	
	# Buscar las partículas de humo
	smoke_particles = find_child("SmokeParticles", true, false) as CPUParticles3D
	
	if area_3d:
		print("Area3D found for collision detection")
		area_3d.body_entered.connect(_on_body_entered)
		area_3d.area_entered.connect(_on_area_entered)
	else:
		print("WARNING: Area3D not found")
	
	if mesh_instance:
		print("MeshInstance3D found for animation")
	else:
		print("WARNING: MeshInstance3D not found")
	
	if smoke_particles:
		print("SmokeParticles found")
	else:
		print("WARNING: SmokeParticles not found")

func _on_body_entered(body: Node3D) -> void:
	"""Detecta cuando un cuerpo entra en el área"""
	if is_crushed:
		return
	
	print("Body entered enemy: ", body.name, " | Type: ", body.get_class())
	
	if body.is_in_group("player") or body.name.contains("Player"):
		_check_crush(body)

func _on_area_entered(area: Area3D) -> void:
	"""Detecta cuando un área entra en el área del enemigo"""
	if is_crushed:
		return
	
	print("Area entered enemy: ", area.name)
	
	if area.is_in_group("player"):
		var body = area.get_parent() as Node3D
		if body:
			_check_crush(body)

func _check_crush(player: Node3D) -> void:
	"""Verifica si el jugador golpea desde arriba"""
	# Comparar la altura del jugador con la del enemigo
	var player_y = player.global_position.y
	var enemy_y = global_position.y
	
	# Si el jugador está más arriba que la mitad superior del enemigo, crush
	if player_y > enemy_y:
		print("Enemy crushed by player!")
		crush_enemy()

func crush_enemy() -> void:
	"""Aplica la animación de crush y destruye el enemigo"""
	is_crushed = true
	
	print("Crushing enemy...")
	
	# Activar partículas de humo inmediatamente
	if smoke_particles:
		smoke_particles.emitting = true
	
	# Buscar el jugador para aplicar el rebote
	var player = get_tree().root.find_child("Player", true, false) as CharacterBody3D
	if player:
		print("Applying bounce force to player: ", bounce_force)
		# Acceder directamente a la velocidad si es un CharacterBody3D
		player.velocity.y = bounce_force
	
	# Animar solo el escalado visual de la malla, no del colisionador
	if mesh_instance:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN)
		tween.tween_property(mesh_instance, "scale:y", crush_scale, crush_duration)
	
	# Destruir después de la animación
	await get_tree().create_timer(crush_duration).timeout
	
	print("Enemy destroyed!")
	queue_free()

func _process(_delta: float) -> void:
	pass
