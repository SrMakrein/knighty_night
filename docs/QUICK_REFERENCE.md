# KnightyNight - Quick Reference

## File Locations

| Component | Path |
|-----------|------|
| Main Scene | `scenes/levels/main.tscn` |
| Player Scene | `scenes/player/Player.tscn` |
| Player Logic | `scripts/player/PlayerController.gd` |
| Camera Logic | `scripts/player/CameraController.gd` |
| Animations | `scripts/player/AnimationController.gd` |
| Level Manager | `scripts/managers/MainLevel.gd` |
| Character Model | `assets/models/knight.blend` |
| Project Settings | `project.godot` |

## Input Map Configuration

All input actions are configured in `project.godot` under `[input]`:

- **move_forward** → W + Left Stick Y (up)
- **move_backward** → S + Left Stick Y (down)
- **move_left** → A + Left Stick X (left)
- **move_right** → D + Left Stick X (right)
- **jump** → Space + A Button
- **run** → Shift + LB Button
- **camera_left** → Mouse X (left) + Right Stick X (left)
- **camera_right** → Mouse X (right) + Right Stick X (right)
- **camera_up** → Mouse Y (up) + Right Stick Y (up)
- **camera_down** → Mouse Y (down) + Right Stick Y (down)

## Scene Hierarchy

```
Main (Node3D)
├── DirectionalLight3D      (Sun)
├── WorldEnvironment        (Lighting)
├── Ground (StaticBody3D)   (Main platform)
├── Platform1 (StaticBody3D) (Jump platform)
├── Platform2 (StaticBody3D) (Jump platform)
└── Player (CharacterBody3D)
    ├── CollisionShape3D    (Capsule)
    ├── Model (Node3D)
    │   └── KnightModel     (3D Model)
    ├── AnimationController (AnimationPlayer)
    └── CameraController (Node3D)
        └── Camera3D
```

## Script Execution Flow

```
_physics_process() [PlayerController]
    ↓
get_input_direction()           → Get WASD/Stick input
    ↓
apply_camera_relative_movement() → Convert to world space
    ↓
Apply gravity and jumping
    ↓
move_and_slide()                → Physics update
    ↓
update_animation()              → Set animation state
    ↓
_process() [CameraController]
    ↓
Calculate camera position
    ↓
Smooth interpolation
    ↓
Look at player
```

## Key Parameters (Edit These to Tune)

### Movement (PlayerController.gd)
```gdscript
max_walk_speed = 5.0      # Increase → Faster walking
max_run_speed = 8.0       # Increase → Faster running
acceleration = 15.0       # Higher → Snappier response
jump_force = 5.0          # Higher → Higher jumps
```

### Camera (CameraController.gd)
```gdscript
distance = 3.0            # Increase → Farther camera
height = 1.5              # Increase → Higher camera
smoothing = 5.0           # Increase → Smoother but slower
gamepad_sensitivity = 2.0 # Increase → Faster stick control
```

## Common Tasks

### Change Walk Speed
1. Open `scripts/player/PlayerController.gd`
2. Find `max_walk_speed = 5.0`
3. Change value (e.g., 7.0 for faster)
4. Save

### Add New Platform
1. Open `scenes/levels/main.tscn` in editor
2. Right-click on "Main" → Add Child Node
3. Search for "StaticBody3D" → Create
4. Rename to "Platform3"
5. Add MeshInstance3D child (with BoxMesh)
6. Add CollisionShape3D child (with BoxShape3D)
7. Position and scale in viewport
8. Save

### Customize Animation Names
1. Open `scripts/player/AnimationController.gd`
2. Find `available_animations` dictionary
3. Update animation names to match your model
4. Save

### Change Input Keys
1. Open `project.godot`
2. Find `[input]` section
3. Edit key codes or add new InputEvent
4. Save (project will reload)

## Animation Names to Update

Look for these in your knight.blend model. If animation names differ, update in `AnimationController.gd`:

- Idle animation name
- Walk animation name
- Run animation name
- Jump animation name

## Testing Checklist

- [ ] Game starts without errors (F5)
- [ ] WASD moves character forward/backward/left/right
- [ ] Camera follows player smoothly
- [ ] Space bar makes character jump
- [ ] Shift increases movement speed
- [ ] Mouse/stick look controls camera
- [ ] Character rotates toward movement direction
- [ ] Animations play during movement
- [ ] Player can jump onto platforms
- [ ] Player respawns if fallen off world

## Performance Tips

1. **If camera is jittery:** Increase `smoothing` in CameraController
2. **If character feels slow:** Increase `max_walk_speed` and `max_run_speed`
3. **If camera sensitivity wrong:** Adjust `gamepad_sensitivity` or `mouse_sensitivity`
4. **If animations lag:** Check animation speed in AnimationController

---

**Ready to expand? Check SETUP_GUIDE.md for detailed customization options!**
