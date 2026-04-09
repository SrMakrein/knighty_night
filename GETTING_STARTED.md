# 🎮 KnightyNight - Getting Started Guide

## Quick Decision Tree

```
START HERE
    ↓
   ┌─────────────────────────┐
   │ What do you want to do? │
   └─────────────────────────┘
    ↓
    ├─→ "Just want to play!" 
    │   └→ Go to [Step 1: PLAY](#step-1-play-immediately)
    │
    ├─→ "Want to understand what's here"
    │   └→ Go to [Step 2: LEARN](#step-2-learn-the-systems)
    │
    ├─→ "Want to customize gameplay"
    │   └→ Go to [Step 3: CUSTOMIZE](#step-3-customize-gameplay)
    │
    └─→ "Want to add new features"
        └→ Go to [Step 4: EXTEND](#step-4-extend-with-new-features)
```

---

## Step 1: PLAY Immediately ⏱️ (1 minute)

### What You'll Do
1. Open Godot
2. Open this project
3. Press Play
4. Control character with WASD + Mouse

### Detailed Steps

#### 1.1 Open Godot
```
Launch Godot 4.6 or newer
```

#### 1.2 Open Project
```
File → Open Project
Navigate to: e:\PROYECTOS GODOT\KnightNightly\knighty-night
Click "Select Folder"
Wait for project to load (~30 seconds)
```

#### 1.3 Play
```
Press F5 or click the Play ▶️ button (top right)
Game starts immediately!
```

#### 1.4 Use Controls
| Action | Key |
|--------|-----|
| Move | WASD |
| Jump | Space |
| Run | Shift |
| Look | Mouse |
| Unlock Mouse | ESC |

#### 1.5 Explore
- Walk around the ground platform
- Jump to Platform 1 (easier)
- Jump to Platform 2 (harder)
- Try running with Shift
- Fall off and respawn

---

## Step 2: LEARN the Systems 📚 (15 minutes)

### What You'll Learn
- How movement works
- How camera follows
- How animations play
- How input is handled

### Reading Path

1. **Start:** [README.md](README.md) (2 min)
   - Overview of what exists
   - Quick control reference

2. **Understand:** [SETUP_GUIDE.md](docs/SETUP_GUIDE.md) (10 min)
   - Feature explanations
   - Component details
   - How everything connects

3. **Reference:** [QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md) (3 min)
   - Look at file locations
   - See input mapping
   - Review scene hierarchy

### Key Concepts to Understand

**Physics-Based Movement**
- Character uses gravity simulation
- Jumping adds upward velocity
- Ground detection prevents jumping in air
- Acceleration makes movement smooth

**Camera System**
- Third-person perspective
- Follows player at distance
- Smooth interpolation prevents jitter
- Independent of player rotation

**Animation System**
- State machine approach (Idle/Walk/Run/Jump)
- Automatically switches based on movement
- Easy to extend with new animations

**Input Handling**
- All inputs in project.godot
- Actions like "move_forward" support multiple inputs
- Keyboard and controller work simultaneously

---

## Step 3: CUSTOMIZE Gameplay ⚙️ (30 minutes)

### What You'll Customize
- Movement speed
- Camera position
- Jump height
- Input keys

### Customization Tasks

### 3.1 Make Character Faster/Slower
**File:** `scripts/player/PlayerController.gd`  
**Find:** Lines with `@export var`

```gdscript
@export var max_walk_speed: float = 5.0   # ← Change this number
@export var max_run_speed: float = 8.0    # ← And this one
```

**Try These Values:**
- Very slow: walk=2.0, run=4.0
- Normal: walk=5.0, run=8.0 (current)
- Fast: walk=8.0, run=12.0
- Very fast: walk=12.0, run=18.0

**How to Apply:**
1. Open the file in Godot
2. Find the numbers above
3. Change them to new values
4. Save (Ctrl+S)
5. Press F5 to test

---

### 3.2 Adjust Jump Height
**File:** `scripts/player/PlayerController.gd`  
**Find:** Line with `jump_force`

```gdscript
@export var jump_force: float = 5.0       # ← Change this number
```

**Try These Values:**
- Low jump: 3.0
- Normal: 5.0 (current)
- High jump: 7.0
- Moon jump: 10.0

---

### 3.3 Change Camera Distance/Height
**File:** `scripts/player/CameraController.gd`  
**Find:** Lines with `@export var distance` and `height`

```gdscript
@export var distance: float = 3.0         # ← Camera distance
@export var height: float = 1.5           # ← Camera height
```

**Try These Values:**

For **farther camera:**
```gdscript
distance = 5.0    # Farther away
height = 2.0      # Higher up
```

For **closer camera:**
```gdscript
distance = 2.0    # Closer
height = 1.0      # Lower
```

---

### 3.4 Improve Camera Smoothness
**File:** `scripts/player/CameraController.gd`  
**Find:** Line with `smoothing`

```gdscript
@export var smoothing: float = 5.0        # ← Higher = smoother
```

**Try These Values:**
- Snappy: 3.0 (responds quickly)
- Balanced: 5.0 (current)
- Smooth: 8.0 (floaty feeling)
- Very smooth: 12.0 (very floaty)

---

### 3.5 Adjust Input Sensitivity
**File:** `scripts/player/CameraController.gd`  
**Find:** Lines with sensitivity

```gdscript
@export var gamepad_sensitivity: float = 2.0
@export var mouse_sensitivity: float = 0.005
```

**Try These Values:**

For **controller:**
- Slow: 1.0
- Normal: 2.0 (current)
- Fast: 3.5
- Very fast: 5.0

For **mouse:**
- Slow: 0.003
- Normal: 0.005 (current)
- Fast: 0.008
- Very fast: 0.015

---

### 3.6 Change Key Bindings
**File:** `project.godot`

This is more complex. Instead:
1. Go to Project → Project Settings
2. Click "Input Map" tab
3. Find an action (e.g., "jump")
4. Click the + button to add new input
5. Press the key you want
6. Click OK

---

### 3.7 Add More Platforms
**File:** `scenes/levels/main.tscn`

This requires the Scene editor:
1. Open main.tscn in the Scene tab
2. Right-click on "Main" node
3. Click "Add Child Node"
4. Search and add "StaticBody3D"
5. Right-click it → "Add Child Node"
6. Add "MeshInstance3D" (for visuals)
7. Right-click → "Add Child Node"
8. Add "CollisionShape3D" (for physics)
9. Adjust in the viewport
10. Save

See [SETUP_GUIDE.md](docs/SETUP_GUIDE.md) for detailed platform creation.

---

## Step 4: EXTEND with New Features 🚀 (1-2 hours)

### What You Can Add
- Enemies
- Collectibles
- UI (health, score)
- Sound effects
- More levels
- Combat system

### Extension Path

1. **Read:** [DEVELOPER_GUIDE.md](docs/DEVELOPER_GUIDE.md)
   - Understand architecture
   - See code examples
   - Learn best practices

2. **Pick a Feature:**
   - [Example 1: Add Dash Ability](#example-1-dash)
   - [Example 2: Add Attack System](#example-2-attack)
   - [Example 3: Add Health System](#example-3-health)

3. **Follow the Example**
4. **Modify and Expand**

---

### Example 1: Dash Ability

**What it does:** Character dashes forward when you press a key.

**Steps:**

1. **Add input action** in `project.godot`:
```ini
[input]

dash={
"deadzone": 0.5,
"events": [InputEventKey(...)]
}
```

2. **Add to PlayerController.gd**:
```gdscript
@export var dash_force: float = 15.0
var can_dash: bool = true

func _physics_process(delta):
    # ... existing code ...
    
    if Input.is_action_just_pressed("dash") and can_dash:
        perform_dash()

func perform_dash():
    var direction = apply_camera_relative_movement(get_input_direction())
    velocity.x = direction.x * dash_force
    velocity.z = direction.z * dash_force
    can_dash = false
    await get_tree().create_timer(0.5).timeout
    can_dash = true
```

3. **Update animation**:
```gdscript
func update_animation(...):
    if not can_dash:
        animation_controller.set_state("dash")
```

4. **Test:**
   - Press F5
   - Press dash key
   - Character dashes!

---

### Example 2: Attack System

**What it does:** Character can swing a weapon.

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
   - Open scenes/player/Player.tscn
   - Add child node "Node"
   - Attach CombatSystem.gd script
   - Save

3. **Add input action** in project.godot:
```ini
[input]

attack={
"events": [InputEventKey(...)]
}
```

4. **Test:**
   - Press F5
   - Press attack key
   - Character plays attack animation!

---

### Example 3: Health System

**What it does:** Player has health that decreases when taking damage.

1. **Create** `scripts/player/HealthSystem.gd`:
```gdscript
extends Node

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

2. **Use in game:**
```gdscript
# In any script:
var health_system = get_node("Player/HealthSystem")
health_system.take_damage(10)  # Player takes 10 damage
health_system.heal(5)           # Player heals 5 HP
```

3. **Connect to UI:**
```gdscript
health_system.health_changed.connect(func(health, max_health):
    update_health_bar(health, max_health)
)
```

---

## 📊 Feature Progression Chart

```
BASELINE (You are here)
├─ Character movement ✅
├─ Camera system ✅
├─ Animation ✅
└─ Input handling ✅

↓

PHASE 1: Gameplay Polish (Easy - 30 min)
├─ More platforms
├─ Adjust movement speed
├─ Change camera distance
├─ Add sound effects
└─ Tweak jump height

↓

PHASE 2: Basic Features (Medium - 1-2 hours)
├─ Dash ability
├─ Attack system
├─ Health system
├─ Collectibles
└─ Simple UI

↓

PHASE 3: Advanced Systems (Hard - 2-4 hours)
├─ Enemy AI
├─ Combat system
├─ Level progression
├─ Checkpoint system
└─ Boss encounters

↓

PHASE 4: Polish (Ongoing)
├─ Visual effects
├─ Particle systems
├─ More animations
├─ Better audio
└─ Game feel refinement
```

---

## 🗺️ Where to Go Next

### I Want to...

**"Just play for now"**
→ You're done! Just press F5 and enjoy.

**"Understand the code"**
→ Read [DEVELOPER_GUIDE.md](docs/DEVELOPER_GUIDE.md)

**"Make it faster/slower"**
→ See [Section 3.1-3.6](#step-3-customize-gameplay)

**"Add a new feature"**
→ See [Section 4](#step-4-extend-with-new-features)

**"Change a key binding"**
→ See [Section 3.6](#36-change-key-bindings)

**"Add platforms"**
→ See [Section 3.7](#37-add-more-platforms)

**"Debug something"**
→ See [QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md#troubleshooting)

**"Look up something quickly"**
→ Use [QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md)

---

## ✅ Checklist: Are You Ready?

- [ ] Godot 4.6+ installed
- [ ] Project folder downloaded
- [ ] Godot open
- [ ] Project loaded
- [ ] F5 pressed
- [ ] Character moved around
- [ ] Jumped between platforms
- [ ] Fell and respawned

**If all checked:** You're ready to customize and extend!

---

## 🎯 Common Next Steps

### Most Common (Pick One)
1. **Adjust movement** - Make character faster/slower
2. **Add platforms** - Create more challenges
3. **Improve camera** - Make it feel better
4. **Add sound** - Make game feel alive

### Quick Wins (15-30 min each)
1. Change walk speed
2. Change jump height
3. Adjust camera distance
4. Add ambient music
5. Change ground material color

### Moderate Projects (1-2 hours)
1. Add dash ability
2. Create second level
3. Add health system
4. Add simple collectibles
5. Implement checkpoints

### Big Projects (2+ hours)
1. Enemy AI system
2. Combat system
3. Full level design
4. Multiple levels
5. Boss encounters

---

## 📞 Quick Help

### Game won't start?
- Check Godot version (need 4.6+)
- Check console for errors
- Try reloading the project

### Controls don't work?
- Check Input Map (Project Settings → Input Map)
- Make sure you're in the game window
- Try clicking in the game viewport

### Camera is weird?
- Increase smoothing value
- Adjust distance/height
- Right-click to recapture mouse

### Can't find something?
- Use Ctrl+P to open file search
- Check FILE_STRUCTURE.md for locations
- Look in docs/ folder

---

## 🎉 Ready to Go!

**Pick your path above and get started!**

The game is ready for:
- ✅ Playing immediately
- ✅ Learning the systems
- ✅ Customizing gameplay
- ✅ Extending with features

**What are you waiting for? Press F5!** 🚀

---

**Last Updated:** April 8, 2026  
**Status:** Ready for all skill levels
