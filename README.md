# KnightyNight - Prototipo de Plataforma 3D

Un **prototipo de plataforma 3D completamente funcional** con movimiento de personaje, sistema de cámara, animaciones, coleccionables, menús interactivos, física realista y **sistema de puertas activadas por coleccionables**.

**Versión:** Alpha 0.0.2  
**Estado:** ✅ Completamente jugable

## 🚀 Inicio Rápido

1. **Abre el proyecto en Godot 4.6+**
2. **Presiona F5** para jugar
3. **Usa WASD + Ratón/Controlador para moverte y mirar**
4. **Presiona Espacio para saltar**
5. **Mayúscula para correr**
6. **Esc para pausar**

¡Eso es todo! Todo está configurado y listo para jugar.

---

## 📖 Documentación

- **[IMPLEMENTED_FEATURES.md](docs/IMPLEMENTED_FEATURES.md)** - 📋 Lo que está implementado ahora mismo

---

## 🎮 Controles

### Teclado + Ratón
- **WASD** - Movimiento
- **Espacio** - Saltar
- **Mayúscula** - Correr
- **Ratón** - Mirar alrededor
- **Esc** - Menú de pausa

### Controlador Xbox
- **Stick Izquierdo** - Movimiento
- **Stick Derecho** - Mirar
- **Botón A** - Saltar
- **LB/RB** - Correr

---

## ✨ Lo que está incluido

✅ **Controlador del Jugador**
- Movimiento suave con aceleración/fricción
- Velocidad de caminata: 7.0 u/s
- Velocidad de carrera: 11.0 u/s
- Movimiento relativo a la cámara
- Gravedad y salto realistas
- Detección de suelo

✅ **Sistema de Cámara**
- Cámara en tercera persona
- Control con ratón y gamepad
- Distancia: 5.0 unidades
- Altura: 1.8 unidades
- Interpolación suave

✅ **Sistema de Animación**
- Máquina de estados (Idle, Walk, Run, Jump)
- Transiciones suaves
- Sincronización automática

✅ **Menú Principal**
- Interfaz elegante con animaciones
- Botones interactivos
- Hover effects

✅ **Menú de Pausa**
- Pausa del juego con Esc
- Opciones durante la pausa
- Reanudar o salir

✅ **Sistema de Coleccionables**
- Objetos para recoger en el nivel
- Contador global en HUD
- Gestor de coleccionables persistente

✅ **Sistema de Portales Activados**
- Puertas que se abren al recoger cierta cantidad de coleccionables
- Animación de apertura del portal
- El colisionador se desactiva automáticamente al terminar la animación
- Cantidad de coleccionables configurable por puerta (por defecto 3)

✅ **HUD en Juego**
- Contador de coleccionables
- Interfaz limpia y legible

✅ **Física y Entrada**
- CharacterBody3D con gravedad
- Teclado, ratón y controlador Xbox
- Mapa de entrada completamente configurado

✅ **Nivel**
- Plataforma de tierra principal
- Dos plataformas elevadas para saltar
- Iluminación con sombras
- Reaparición automática si caes

---

## 📁 Estructura del Proyecto

```
knighty-night/
├── scripts/
│   ├── player/
│   │   ├── PlayerController.gd   ← Movimiento (7.0 / 11.0 u/s)
│   │   ├── CameraController.gd   ← Cámara tercera persona
│   │   └── AnimationController.gd ← Estados de animación
│   ├── managers/
│   │   └── MainLevel.gd          ← Gestor de nivel
│   ├── autoload/
│   │   └── CollectibleManager.gd ← Gestor global de coleccionables
│   ├── objects/
│   │   ├── CollectibleController.gd ← Control de coleccionables
│   │   └── PortalController.gd   ← Control de puertas activables
│   └── ui/
│       ├── MenuController.gd
│       ├── PauseController.gd
│       ├── HUDController.gd
│       ├── OptionsController.gd
│       └── OptionsMenuPausaController.gd
├── scenes/
│   ├── player/
│   │   └── Player.tscn
│   ├── levels/
│   │   └── main.tscn
│   ├── objects/
│   │   └── Collectible.tscn
│   └── ui/
│       ├── Menu.tscn          ← Escena de inicio
│       ├── PauseMenu.tscn
│       ├── HUD.tscn
│       ├── OptionsMenu.tscn
│       └── OptionsMenuPausa.tscn
├── assets/
│   └── models/
│       ├── knight.blend       (personaje principal)
│       ├── shield.blend
│       ├── sword.blend
│       ├── portal.blend       (puerta activable)
│       └── knight_statue.blend
└── docs/
    ├── IMPLEMENTED_FEATURES.md  ← LO QUE ESTÁ HECHO
    ├── SETUP_GUIDE.md
    ├── QUICK_REFERENCE.md
    ├── DEVELOPER_GUIDE.md
    └── IMPLEMENTATION_CHECKLIST.md
```

---

## ⚙️ Parámetros Principales

### PlayerController
```gdscript
max_walk_speed = 7.0         # Velocidad caminata
max_run_speed = 11.0         # Velocidad carrera
acceleration = 30.0          # Aceleración
friction = 25.0              # Fricción
gravity = 15.0               # Gravedad
jump_force = 8.0             # Fuerza salto
```

### CameraController
```gdscript
distance = 5.0               # Distancia de cámara
height = 1.8                 # Altura de cámara
mouse_sensitivity = 0.1      # Sensibilidad ratón
gamepad_sensitivity = 3.0    # Sensibilidad stick
min_pitch = -60.0            # Ángulo mín vertical
max_pitch = 60.0             # Ángulo máx vertical
```

---

---

## 🎯 Características

- ✅ Movimiento 3D fluido con aceleración
- ✅ Cámara en tercera persona (ratón + gamepad)
- ✅ Física de salto y gravedad realista
- ✅ Detección de suelo
- ✅ Animaciones suaves (Idle/Walk/Run/Jump)
- ✅ Soporte Teclado + Controlador Xbox
- ✅ Menú principal con animaciones
- ✅ Sistema de pausa funcional
- ✅ Coleccionables con seguimiento
- ✅ HUD con información
- ✅ Múltiples plataformas
- ✅ Código limpio y modular
- ✅ Completamente documentado
- ✅ Listo para expandir

---

## 🔧 Sin Configuración Extra Requerida

Todo está preconfigurado:
- ✅ Mapa de entrada completo
- ✅ Scripts adjuntos en escenas
- ✅ Escenas de UI listas
- ✅ Física configurada
- ✅ Menu.tscn como escena inicial
- ✅ AutoLoad: CollectibleManager

**¡Solo presiona F5!**

---

## 📚 Próximos Pasos

1. **Juega el juego** - Explora las plataformas y coleccionables
2. **Lee IMPLEMENTED_FEATURES.md** - Entiende qué está hecho
3. **Experimenta con parámetros** - Ajusta velocidades y cámara
4. **Extiende el proyecto** - Agrega enemigos, nuevos niveles, etc.

### Ideas para Construir
- Sistema de combate
- Enemigos con IA
- Más niveles
- Efectos de sonido y música
- Sistema de puntuación avanzado
- Power-ups y bonificadores
- Cinemáticas
- Historia/Narrativa

---

## 📋 Requisitos Cumplidos

✅ Personaje 3D controlable (CharacterBody3D)
✅ Movimiento con aceleración/fricción
✅ Gravedad y salto realista
✅ Movimiento relativo a cámara
✅ Cámara tercera persona siguiendo
✅ Cámara suave sin parpadeos
✅ Control ratón + stick derecho
✅ Entrada teclado (WASD + Espacio + Mayúscula)
✅ Entrada Controlador Xbox (sticks + botones)
✅ Sistema animación completo
✅ Menú principal funcional
✅ Menú de pausa
✅ Nivel con plataformas
✅ Iluminación y sombras
✅ Sistema de coleccionables
✅ **Sistema de puertas activadas por coleccionables** ⭐ **NUEVO**
✅ HUD de información
✅ Física y colisiones
✅ Detección suelo
✅ Código modular en GDScript
✅ Bien documentado
✅ Sin plugins externos
✅ Inmediatamente jugable

---

## 🐛 Solución de Problemas

**¿El menú no carga?**
- Verifica que Menu.tscn está en scenes/ui/
- Comprueba que project.godot tiene Menu.tscn como run/main_scene

**¿El personaje no se mueve?**
- Verifica el Mapa de Entrada (Project Settings > Input Map)
- Asegúrate de que los scripts están adjuntos en Player.tscn

**¿La cámara se comporta raro?**
- Aumenta/reduce mouse_sensitivity en CameraController
- Ajusta gamepad_sensitivity para controles
- Verifica que el ratón está capturado

**¿Las animaciones no se reproducen?**
- Verifica que knight.blend tiene las animaciones: Idle, Walk, Run, Jump
- Comprueba que AnimationController.gd está adjunto

---

## 📖 Archivos de Documentación

| Archivo | Contenido |
|---------|-----------|
| **IMPLEMENTED_FEATURES.md** | ✨ Todas las características implementadas actualmente |
| **SETUP_GUIDE.md** | Guía de configuración y características |
| **QUICK_REFERENCE.md** | Referencia rápida de tareas comunes |
| **DEVELOPER_GUIDE.md** | Arquitectura, extensión y modificación |
| **IMPLEMENTATION_CHECKLIST.md** | Verificación de requisitos |

---

## 🎮 ¡Presiona F5 y Diviértete!

Todo está configurado y listo. Abre Godot, carga este proyecto y presiona **F5**.

El juego es completamente jugable de inmediato. No se requiere configuración adicional.

**¡Disfruta KnightyNight!** 🚀

---

**Versión:** Alpha 0.0.2  
**Creado:** 10 de Abril de 2026  
**Godot:** 4.6+  
**Estado:** ✅ Completamente Funcional**¡Solo presiona Play!**

---

## 📚 Próximos Pasos

1. **Juega el juego** - Siéntete cómodo con la mecánica
2. **Lee SETUP_GUIDE.md** - Entiende qué está implementado
3. **Experimenta con QUICK_REFERENCE.md** - Ajusta parámetros
4. **Extiende usando DEVELOPER_GUIDE.md** - Agrega nuevas características

### Ideas para Construir
- Agrega enemigos
- Agrega objetos coleccionables
- Agrega UI (salud, puntuación)
- Agrega efectos de sonido
- Crea más niveles
- Agrega sistema de combate
- Agrega power-ups

---

## 📋 Requisitos Cumplidos

✅ Personaje 3D controlable (CharacterBody3D)
✅ Movimiento, salto, gravedad
✅ Movimiento relativo a la cámara
✅ Cámara en tercera persona siguiendo
✅ Cámara suave (sin parpadeos)
✅ Control de cámara con Ratón + Stick
✅ Entrada de teclado (WASD + Espacio + Mayúscula)
✅ Entrada de Controlador Xbox (stick izquierdo, stick derecho, A, LB/RB)
✅ Sistema de animación (Inactivo, Caminar, Correr, Saltar)
✅ Escena principal con jugador y plataformas
✅ Iluminación
✅ Física y colisiones básicas
✅ Detección de suelo
✅ Código limpio y modular en GDScript
✅ Bien documentado
✅ Sin plugins externos
✅ Listo para jugar inmediatamente

---

## 🐛 Solución de Problemas

**¿El personaje no se mueve?**
- Verifica el Mapa de Entrada (Project Settings > Input Map)
- Verifica que los scripts están adjuntos en las escenas

**¿Cámara atascada?**
- Aumenta `smoothing` en CameraController (mayor = más suave)
- Haz clic derecho para recapturar el ratón

**¿Las animaciones no se reproducen?**
- Verifica los nombres de las animaciones en AnimationController.gd
- Verifica que knight.blend tiene las animaciones con nombres correctos

Consulta **QUICK_REFERENCE.md** para más solución de problemas.

---

## 📖 Archivos de Documentación

| Archivo | Propósito |
|---------|-----------|
| **SETUP_GUIDE.md** | Lista completa de características, personalización, solución de problemas |
| **QUICK_REFERENCE.md** | Referencia rápida, tareas comunes, lista de verificación de pruebas |
| **DEVELOPER_GUIDE.md** | Arquitectura, extensión de características, ajuste de física |
| **IMPLEMENTATION_CHECKLIST.md** | Qué ha sido construido, próximos pasos, estado |

---

## 🎮 ¡Presiona Play y Diviértete!

Todo está configurado y listo. Abre Godot, abre este proyecto y presiona **F5**.

El prototipo es jugable inmediatamente. No se requiere configuración adicional.

**¡Disfruta tu plataforma 3D!** 🚀

---

**Versión:** 1.0  
**Creado:** 8 de Abril de 2026  
**Versión de Godot:** 4.6+  
**Estado:** ✅ Listo para Jugar
