## Animation Controller - Manages character animations
extends AnimationPlayer

class_name AnimationController

# Animation state
var current_state: String = "idle"
var animation_speed: float = 1.0

# Available animations (these should match your model's animations)
# Update these names to match your knight.blend animations
var available_animations: Dictionary = {
	"idle": "Idle",
	"walk": "Walk",
	"jump": "Jump"
}

func _ready() -> void:
	# Connect animation finished signal
	animation_finished.connect(_on_animation_finished)
	
	# Print available animations from the model
	var available = get_animation_list()
	print("=== Animaciones disponibles en el modelo ===")
	for anim in available:
		print("  - " + anim)
	print("==========================================")
	
	# Auto-detectar las animaciones disponibles
	if "Idle" in available:
		available_animations["idle"] = "Idle"
	if "idle" in available:
		available_animations["idle"] = "idle"
	
	if "Walk" in available:
		available_animations["walk"] = "Walk"
	if "walk" in available:
		available_animations["walk"] = "walk"
	if "Walking" in available:
		available_animations["walk"] = "Walking"
	
	if "Jump" in available:
		available_animations["jump"] = "Jump"
	if "jump" in available:
		available_animations["jump"] = "jump"
	if "Jumping" in available:
		available_animations["jump"] = "Jumping"

func _on_animation_finished(_anim_name: String) -> void:
	"""Called when an animation finishes"""
	# Loop idle animation
	if current_state == "idle" and has_animation(available_animations["idle"]):
		play(available_animations["idle"])

func set_state(new_state: String) -> void:
	"""Set the current animation state"""
	if new_state == current_state:
		return
	
	if new_state not in available_animations:
		return
	
	current_state = new_state
	var anim_name = available_animations[new_state]
	
	# Only play if animation exists
	if has_animation(anim_name):
		play(anim_name)

func set_animation_speed(speed: float) -> void:
	"""Set the playback speed of animations"""
	animation_speed = speed
	speed_scale = speed

func get_current_state() -> String:
	"""Get the current animation state"""
	return current_state

# Optional: Add method to register custom animations if needed later
func register_animation(state: String, animation_name: String) -> void:
	"""Register a custom animation"""
	available_animations[state] = animation_name
