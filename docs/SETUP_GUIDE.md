# KnightyNight 3D Platformer Prototype

## Quick Start

1. **Open the project in Godot 4.6+**
2. **Press Play** (F5) to run the game

The prototype is ready to use immediately!

---

## Project Structure

```
knighty-night/
├── scenes/
│   ├── player/
│   │   └── Player.tscn          # Player scene (character, collision, camera)
│   ├── levels/
│   │   └── main.tscn            # Main playable level
│   ├── enemies/
│   ├── ui/
│   ├── objects/
│
├── scripts/
│   ├── player/
│   │   ├── PlayerController.gd  # Character movement & gravity
│   │   ├── CameraController.gd  # Third-person camera system
│   │   └── AnimationController.gd # Animation state machine
│   ├── managers/
│   │   └── MainLevel.gd         # Level manager
│   ├── enemies/
│   ├── ui/
│   ├── objects/
│
├── assets/
│   ├── models/
│   │   ├── knight.blend         # Main character model
│   │   ├── shield.blend
│   │   └── sword.blend
│   ├── images/
│   ├── audio/
│   ├── fonts/
│   ├── materials/
│
└── docs/
```

---

## Input Controls

### Keyboard + Mouse
- **WASD** - Move character
- **Space** - Jump
- **Shift** - Run
- **Mouse** - Look around (camera)
- **Esc** - Unlock/lock mouse

### Xbox Controller
- **Left Stick** - Move character
- **Right Stick** - Look around (camera)
- **A Button** - Jump
- **LB (Left Bumper)** - Run
- **RB (Right Bumper)** - Run (alternative)

---

## Game Features

### Player Controller (`PlayerController.gd`)
- ✓ WASD + Gamepad movement
- ✓ Gravity and jumping
- ✓ Ground detection
- ✓ Camera-relative movement (move towards where camera looks)
- ✓ Acceleration and friction for smooth motion
- ✓ Character rotation towards movement direction
- ✓ Run/walk speed switching

### Camera System (`CameraController.gd`)
- ✓ Third-person perspective
- ✓ Mouse and gamepad control
- ✓ Smooth interpolation (no jitter)
- ✓ Pitch and yaw control
- ✓ Follows player with offset
- ✓ Configurable sensitivity and distance

### Animation System (`AnimationController.gd`)
- ✓ State-based animation switching
- ✓ Idle, Walk, Run, Jump animations
- ✓ Ready for custom animations
- ✓ Animation speed control

### Level (`main.tscn`)
- ✓ Ground platform (large)
- ✓ Two elevated platforms for jumping
- ✓ Directional lighting with shadows
- ✓ Ambient lighting for visibility
- ✓ Player respawn if fallen off world

---

## Key Classes

### PlayerController (CharacterBody3D)
Main character controller handling movement and physics.

**Exports:**
- `max_walk_speed: 5.0` - Walking speed
- `max_run_speed: 8.0` - Running speed
- `acceleration: 15.0` - Movement acceleration
- `gravity: 9.8` - Gravity strength
- `jump_force: 5.0` - Jump height

**Key Methods:**
- `_physics_process(delta)` - Main game loop
- `get_input_direction()` - Get WASD/stick input
- `apply_camera_relative_movement()` - Align movement with camera
- `update_animation()` - Sync animation with state

### CameraController (Node3D)
Third-person camera following player.

**Exports:**
- `distance: 3.0` - Distance from player
- `height: 1.5` - Camera height above player
- `smoothing: 5.0` - Camera smoothness
- `mouse_sensitivity: 0.005` - Mouse look speed
- `gamepad_sensitivity: 2.0` - Stick look speed
- `min_pitch: -45.0` - Min vertical angle
- `max_pitch: 45.0` - Max vertical angle

### AnimationController (AnimationPlayer)
Manages animation state transitions.

**Key Methods:**
- `set_state(new_state)` - Change animation state
- `get_current_state()` - Get current animation
- `register_animation()` - Add new animations

---

## Animation Setup

Your knight model should have these animations defined:
- **Idle** - Default standing pose
- **Walk** - Walking animation
- **Run** - Running animation  
- **Jump** - Jumping animation

If your animations have different names, update `AnimationController.gd`:

```gdscript
var available_animations: Dictionary = {
    "idle": "YourIdleAnimName",
    "walk": "YourWalkAnimName",
    "run": "YourRunAnimName",
    "jump": "YourJumpAnimName"
}
```

---

## Customization Guide

### Adjust Movement Speed
Edit `PlayerController.gd`:
```gdscript
@export var max_walk_speed: float = 5.0    # Increase for faster walking
@export var max_run_speed: float = 8.0     # Increase for faster running
```

### Change Camera Distance
Edit `CameraController.gd`:
```gdscript
@export var distance: float = 3.0          # Farther = 5.0, Closer = 2.0
@export var height: float = 1.5            # Higher = 2.0
```

### Adjust Jump Height
Edit `PlayerController.gd`:
```gdscript
@export var jump_force: float = 5.0        # Higher = bigger jumps
```

### Add Platforms
Edit `scenes/levels/main.tscn` in the Scene editor:
1. Add new `StaticBody3D` node
2. Add `MeshInstance3D` as child (with BoxMesh)
3. Add `CollisionShape3D` as child (with BoxShape3D)
4. Position and scale as needed

---

## Next Steps (Expansion Ideas)

### To Add Enemies:
1. Create `scenes/enemies/Enemy.tscn`
2. Create `scripts/enemies/EnemyAI.gd`
3. Implement pathfinding and combat

### To Add UI:
1. Create `scenes/ui/HUD.tscn`
2. Create `scripts/ui/HUDManager.gd`
3. Add health, score, objective displays

### To Add Objects:
1. Create `scenes/objects/Collectible.tscn`
2. Create `scripts/objects/Collectible.gd`
3. Add pickup mechanics

### To Add Audio:
1. Place audio files in `assets/audio/`
2. Create `scripts/managers/AudioManager.gd`
3. Implement sound effects and music

---

## Troubleshooting

### Character doesn't move
- Check Input Map in Project Settings
- Verify scripts are attached to nodes
- Check console for errors (View > Output)

### Camera is stuck or jerky
- Increase `smoothing` value in CameraController
- Check mouse sensitivity settings
- Ensure right-click holds mouse capture

### Animations don't play
- Verify animation names match in AnimationController
- Check that knight.blend has animations exported
- Ensure AnimationPlayer node is set up correctly

### Controller not working
- Check Input Map has gamepad events
- Try pressing buttons on controller to verify it's detected
- Check deadzone settings (currently 0.5)

---

## Performance Notes

- Current setup uses simple box geometry for platforms
- Lighting uses shadows (good quality, slight performance cost)
- Camera smoothing set to 5.0 (adjust if too much lag)
- Physics engine: Jolt Physics (excellent 3D performance)

---

## Credits

- Built with Godot 4.6+
- Uses knight.blend model from assets
- Implements classic 3D platformer mechanics

---

## License

This prototype is part of the KnightyNight project.

---

**Happy platforming!** 🎮
