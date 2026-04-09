# KnightyNight - Developer Guide

## Architecture Overview

The prototype follows a modular, component-based architecture:

```
Player (Root)
├── Physics Layer (CharacterBody3D + PlayerController)
├── Camera Layer (CameraController + Camera3D)
└── Animation Layer (AnimationController)
```

Each system is independent and communicates through node references.

---

## System Details

### 1. Physics & Movement System (PlayerController.gd)

**Responsibilities:**
- Handle input via Input Map
- Apply physics (gravity, jumping, collisions)
- Manage movement and acceleration
- Rotate player toward movement direction
- Communicate with animation system

**Key Methods:**

```gdscript
func _physics_process(delta: float) -> void
    # Main update loop, called every frame
    
func get_input_direction() -> Vector2
    # Returns normalized input vector from WASD/stick
    
func apply_camera_relative_movement(input: Vector2) -> Vector3
    # Converts 2D input to 3D world space relative to camera
    
func update_animation(magnitude: float, running: bool, grounded: bool) -> void
    # Updates animation state based on current state
```

**State Variables:**
- `current_speed` - Current movement speed (0 to max)
- `is_grounded` - Whether player is on ground
- `velocity` - Current velocity (inherited from CharacterBody3D)

**Tuning Parameters:**
- Movement speeds, acceleration, gravity, jump force (see Quick Reference)

---

### 2. Camera System (CameraController.gd)

**Responsibilities:**
- Track player position
- Calculate camera position based on angles
- Handle mouse/stick input for camera control
- Provide camera directions to other systems

**Key Methods:**

```gdscript
func _process(delta: float) -> void
    # Updates camera position and rotation
    
func calculate_camera_position() -> Vector3
    # Spherical coordinate calculation for camera placement
    
func get_camera_forward() -> Vector3
    # Returns direction camera is looking (for movement)
    
func get_camera_right() -> Vector3
    # Returns right direction relative to camera
```

**State Variables:**
- `pitch` - Vertical angle (-45 to 45 degrees)
- `yaw` - Horizontal angle (any value)
- `camera_3d` - Reference to Camera3D node

**Input Handling:**
- Reads camera_left/right/up/down actions
- Supports both mouse and gamepad input
- Mouse can be locked/unlocked with right-click and ESC

---

### 3. Animation System (AnimationController.gd)

**Responsibilities:**
- Manage animation states
- Switch animations based on player state
- Handle animation speed

**Key Methods:**

```gdscript
func set_state(new_state: String) -> void
    # Change to new animation state
    # Only changes if state differs from current
    
func set_animation_speed(speed: float) -> void
    # Adjust playback speed of current animation
    
func register_animation(state: str, anim_name: str) -> void
    # Add/override an animation mapping
```

**State Dictionary:**
```gdscript
available_animations: Dictionary = {
    "idle": "Idle",
    "walk": "Walk",
    "run": "Run",
    "jump": "Jump"
}
```

---

### 4. Level Manager (MainLevel.gd)

**Responsibilities:**
- Initialize level
- Handle level-wide mechanics (respawning, etc.)
- Manage transitions

**Current Features:**
- Player respawn if fallen off world (y < -10)
- Success feedback message

---

## Input System

All inputs defined in `project.godot` under `[input]`:

### Creating New Input Actions

1. **Add to project.godot:**
```ini
[input]

new_action={
"deadzone": 0.5,
"events": [InputEventKey(...), InputEventJoypadButton(...)]
}
```

2. **Use in script:**
```gdscript
if Input.is_action_pressed("new_action"):
    do_something()
    
if Input.is_action_just_pressed("new_action"):
    do_once()
```

### Input Action Reference

| Action | Type | Usage |
|--------|------|-------|
| move_* | Axis | Player movement |
| jump | Button | Jump trigger |
| run | Button | Run modifier |
| camera_* | Axis | Camera look |

---

## Adding New Features

### Example 1: Add A Dash Ability

1. **Add input action** to project.godot:
```ini
dash={
"events": [InputEventKey(...), InputEventJoypadButton(...)]
}
```

2. **Add to PlayerController.gd:**
```gdscript
@export var dash_force: float = 15.0
@export var dash_cooldown: float = 1.0
var can_dash: bool = true

func _physics_process(delta):
    if Input.is_action_just_pressed("dash") and can_dash:
        perform_dash()
        
func perform_dash():
    var direction = apply_camera_relative_movement(get_input_direction())
    velocity.x = direction.x * dash_force
    velocity.z = direction.z * dash_force
    can_dash = false
    await get_tree().create_timer(dash_cooldown).timeout
    can_dash = true
```

3. **Update animation:**
```gdscript
func update_animation(...):
    if dashing:
        animation_controller.set_state("dash")
```

### Example 2: Add Attack System

1. **Create** `scripts/player/CombatSystem.gd`:
```gdscript
extends Node

@onready var player = get_parent()
@export var attack_cooldown: float = 0.5
var can_attack: bool = true

func _physics_process(delta):
    if Input.is_action_just_pressed("attack") and can_attack:
        perform_attack()

func perform_attack():
    can_attack = false
    player.animation_controller.set_state("attack")
    await get_tree().create_timer(attack_cooldown).timeout
    can_attack = true
```

2. **Attach to Player.tscn:**
   - Add CombatSystem as child of Player
   - Attach script to it

### Example 3: Add Health System

1. **Create** `scripts/player/HealthSystem.gd`:
```gdscript
extends Node

class_name HealthSystem

@export var max_health: int = 100
var current_health: int

signal health_changed(new_health: int, max_health: int)
signal died

func _ready():
    current_health = max_health

func take_damage(amount: int):
    current_health = max(0, current_health - amount)
    health_changed.emit(current_health, max_health)
    
    if current_health <= 0:
        died.emit()

func heal(amount: int):
    current_health = min(max_health, current_health + amount)
    health_changed.emit(current_health, max_health)
```

---

## Extending Animation System

### Adding Multiple Animation Trees

For complex animations, use AnimationTree instead of AnimationPlayer:

1. **Create AnimationTree node**
2. **Set AnimationPlayer as reference**
3. **Configure state machine** in AnimationTree
4. **Access states:**

```gdscript
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func set_animation_state(state: String):
    playback.travel(state)
```

---

## Physics Tuning

### Character Controller Best Practices

1. **Acceleration & Friction:**
   - High acceleration = Twitchy, responsive
   - Low friction = Slippery, floaty
   - Balanced = Tight controls

2. **Jump Force & Gravity:**
   - Gravity 9.8 = Real-world physics
   - Jump force 5.0 = ~1.3 second airtime
   - Increase both proportionally for "snappier" feel

3. **Ground Detection:**
   - Uses CharacterBody3D's `is_on_floor()`
   - Requires proper collision layers
   - Check collision shapes are set correctly

---

## Performance Optimization

### Profiling

Use Godot's built-in profiler:
1. Run game (F5)
2. Debug → Monitor (bottom right)
3. Check FPS and physics frame time

### Optimization Tips

1. **Camera Smoothing:**
   - Higher values = smoother but more latency
   - Default 5.0 is good balance

2. **Animation:**
   - Use AnimationPlayer for simple cases
   - Use AnimationTree for complex blending

3. **Collision:**
   - Keep collision shapes simple (capsules, boxes)
   - Avoid complex mesh collisions

4. **Lighting:**
   - Disable shadows if needed: `shadow_enabled = false`
   - Use cheaper directional lights over point lights

---

## Debugging

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| Character stuck | Collision overlap | Check collision shapes |
| Jittery movement | Low physics FPS | Check performance monitor |
| Camera lag | Low smoothing | Increase smoothing value |
| Input not working | Wrong Input Map | Check project.godot [input] |
| No animations | Animation names wrong | Update AnimationController |

### Useful Debug Methods

```gdscript
# In any script:
print("Variable: ", variable)          # Print to console
push_error("Error message")              # Print error
push_warning("Warning message")          # Print warning
@warning_ignore("unused_variable")       # Suppress warnings

# In PlayerController:
velocity  # Print current velocity
is_on_floor()  # Check if grounded
global_position  # Check player position
```

---

## Code Style Guidelines

Follow these conventions in this project:

```gdscript
# Classes
class_name MyClass

# Constants
const MAX_SPEED = 10.0

# Exports (visible in editor)
@export var speed: float = 5.0

# Onready (cached node references)
@onready var camera = $Camera3D

# Private variables
var _internal_state: int = 0

# Public methods
func public_method() -> void:
    pass

# Private methods (prefix with _)
func _private_method() -> void:
    pass

# Signals
signal state_changed(new_state: String)

# Use descriptive names
var player_current_velocity: Vector3
var is_ground_detection_enabled: bool
```

---

## File Organization

Keep adding features to appropriate directories:

- **Player features** → `scripts/player/`
- **Enemy logic** → `scripts/enemies/`
- **UI logic** → `scripts/ui/`
- **Game logic** → `scripts/managers/`
- **Reusable utilities** → `scripts/utils/` (create if needed)

---

## Version Control Tips

Useful .gitignore entries already present. Before committing:

```bash
# Check for large files
git ls-files | sort -k5 -h | tail -5

# View changes before commit
git diff
```

---

## Testing Checklist Before Publishing

- [ ] Game starts without errors
- [ ] All inputs work (keyboard and controller)
- [ ] No console warnings or errors
- [ ] Performance is 60+ FPS
- [ ] Player can complete basic platforming
- [ ] Camera is smooth and responsive
- [ ] Animations play correctly
- [ ] Physics feels good
- [ ] No memory leaks (check monitor)

---

## Resources

- **Godot Docs:** https://docs.godotengine.org/en/stable/
- **GDScript Guide:** https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/index.html
- **CharacterBody3D:** https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html
- **Input Mapping:** https://docs.godotengine.org/en/stable/tutorials/inputs/using_inputs.html

---

**Happy coding! Feel free to expand and customize!** 🚀
