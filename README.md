# KnightyNight 3D Platformer Prototype

A **fully functional 3D platformer** with character movement, camera system, animations, and physics.

## 🚀 Quick Start

1. **Open in Godot 4.6+**
2. **Press F5** to play
3. **Use WASD + Mouse/Controller to move and look**
4. **Press Space to jump**
5. **Shift to run**

That's it! Everything is ready to play.

---

## 📖 Documentation

- **[SETUP_GUIDE.md](docs/SETUP_GUIDE.md)** - Complete guide with features and customization
- **[QUICK_REFERENCE.md](docs/QUICK_REFERENCE.md)** - Quick lookup for developers
- **[DEVELOPER_GUIDE.md](docs/DEVELOPER_GUIDE.md)** - Architecture and how to extend
- **[IMPLEMENTATION_CHECKLIST.md](docs/IMPLEMENTATION_CHECKLIST.md)** - What's been built

---

## 🎮 Controls

### Keyboard + Mouse
- **WASD** - Move
- **Space** - Jump
- **Shift** - Run
- **Mouse** - Look around
- **Esc** - Unlock mouse

### Xbox Controller
- **Left Stick** - Move
- **Right Stick** - Look
- **A Button** - Jump
- **LB/RB** - Run

---

## ✨ What's Included

✅ **Player Controller**
- Smooth movement with acceleration/friction
- Camera-relative directional movement
- Gravity and jumping
- Ground detection
- Walk/Run modes

✅ **Camera System**
- Third-person follow camera
- Mouse and gamepad control
- Smooth interpolation
- Configurable distance and height

✅ **Animation System**
- State-based animation blending
- Idle, Walk, Run, Jump animations
- Ready for your model's animations

✅ **Input System**
- Keyboard, Mouse, and Xbox Controller support
- Fully configurable in project.godot

✅ **Level**
- Ground platform
- Two jump platforms
- Lighting with shadows
- Player respawn on fall

---

## 📁 Project Structure

```
knighty-night/
├── scripts/
│   ├── player/
│   │   ├── PlayerController.gd   ← Character movement
│   │   ├── CameraController.gd   ← Camera follow
│   │   └── AnimationController.gd ← Animation states
│   └── managers/
│       └── MainLevel.gd          ← Level manager
├── scenes/
│   ├── player/
│   │   └── Player.tscn           ← Player scene
│   └── levels/
│       └── main.tscn             ← Main level
├── assets/
│   └── models/
│       ├── knight.blend          (your character)
│       ├── shield.blend
│       └── sword.blend
├── docs/
│   ├── SETUP_GUIDE.md
│   ├── QUICK_REFERENCE.md
│   ├── DEVELOPER_GUIDE.md
│   └── IMPLEMENTATION_CHECKLIST.md
└── project.godot                 (configured)
```

---

## ⚙️ Customization

### Adjust Movement Speed
Open `scripts/player/PlayerController.gd`:
```gdscript
@export var max_walk_speed: float = 5.0  # Change this
@export var max_run_speed: float = 8.0   # And this
```

### Change Camera Distance
Open `scripts/player/CameraController.gd`:
```gdscript
@export var distance: float = 3.0        # Increase for farther camera
@export var height: float = 1.5          # Increase for higher camera
```

### Add More Platforms
Open `scenes/levels/main.tscn` in the Scene editor and add new `StaticBody3D` nodes with mesh and collision shapes.

See **SETUP_GUIDE.md** for detailed customization options.

---

## 🎯 Features

- ✅ Smooth 3D character movement
- ✅ Third-person camera with mouse/stick control
- ✅ Jump and gravity physics
- ✅ Ground detection
- ✅ Animation blending (Idle/Walk/Run/Jump)
- ✅ Keyboard + Xbox Controller support
- ✅ Multiple platforms to explore
- ✅ Clean, modular code
- ✅ Fully documented
- ✅ Ready to extend

---

## 🔧 No Setup Required

Everything is pre-configured:
- ✅ Input map ready
- ✅ Scripts attached
- ✅ Scenes set up
- ✅ Physics configured
- ✅ Main scene set as startup scene

**Just press Play!**

---

## 📚 Next Steps

1. **Play the game** - Get a feel for the mechanics
2. **Read SETUP_GUIDE.md** - Understand what's implemented
3. **Experiment with QUICK_REFERENCE.md** - Tweak parameters
4. **Extend using DEVELOPER_GUIDE.md** - Add new features

### Ideas to Build
- Add enemies
- Add collectibles
- Add UI (health, score)
- Add sound effects
- Create more levels
- Add combat system
- Add power-ups

---

## 📋 Requirements Met

✅ Controllable 3D character (CharacterBody3D)
✅ Movement, jump, gravity
✅ Camera-relative movement
✅ Third-person camera following
✅ Smooth camera (no jitter)
✅ Mouse + Stick camera control
✅ Keyboard input (WASD + Space + Shift)
✅ Xbox Controller input (left stick, right stick, A, LB/RB)
✅ Animation system (Idle, Walk, Run, Jump)
✅ Main scene with player and platforms
✅ Lighting
✅ Basic physics and collisions
✅ Ground detection
✅ Clean, modular GDScript code
✅ Well-documented
✅ No external plugins
✅ Ready to play immediately

---

## 🐛 Troubleshooting

**Character doesn't move?**
- Check Input Map (Project Settings > Input Map)
- Verify scripts are attached in scenes

**Camera stuck?**
- Increase `smoothing` in CameraController (higher = smoother)
- Right-click to recapture mouse

**Animations don't play?**
- Check animation names in AnimationController.gd
- Verify knight.blend has animations named correctly

See **QUICK_REFERENCE.md** for more troubleshooting.

---

## 📖 Documentation Files

| File | Purpose |
|------|---------|
| **SETUP_GUIDE.md** | Full feature list, customization, troubleshooting |
| **QUICK_REFERENCE.md** | Quick lookup, common tasks, testing checklist |
| **DEVELOPER_GUIDE.md** | Architecture, extending features, physics tuning |
| **IMPLEMENTATION_CHECKLIST.md** | What's been built, next steps, status |

---

## 🎮 Press Play and Have Fun!

Everything is set up and ready. Launch Godot, open this project, and press **F5**.

The prototype is immediately playable. No additional setup needed.

**Enjoy your 3D platformer!** 🚀

---

**Version:** 1.0  
**Created:** April 8, 2026  
**Godot Version:** 4.6+  
**Status:** ✅ Ready for Play
