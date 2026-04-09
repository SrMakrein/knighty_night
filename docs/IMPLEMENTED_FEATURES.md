# Características Implementadas - KnightyNight

## Estado Actual: Alpha 0.0.1

Documento que detalla todas las características implementadas en el proyecto KnightyNight.

---

## ✅ Núcleo del Juego

### Sistema de Movimiento del Jugador
- **CharacterBody3D** con movimiento suave
- Controles WASD para movimiento omnidireccional
- **Velocidades configurables:**
  - Caminar: 7.0 unidades/segundo
  - Correr: 11.0 unidades/segundo
  - Aceleración: 30.0
  - Fricción: 25.0
- Movimiento relativo a la cámara
- Rotación del personaje hacia la dirección de movimiento
- Sistema de salto con gravedad realista
  - Gravedad: 15.0
  - Fuerza de salto: 8.0
  - Detección de suelo

### Sistema de Cámara 3D
- Cámara en tercera persona siguiendo al jugador
- **Parámetros:**
  - Distancia: 5.0 unidades
  - Altura: 1.8 unidades
  - Sensibilidad del ratón: 0.1
  - Sensibilidad del gamepad: 3.0
  - Rango de pitch: -60° a 60°
- Control con ratón (movimiento libre)
- Control con stick derecho del gamepad
- Interpolación suave sin parpadeos
- Captura/liberación del ratón (clic derecho)

### Sistema de Animaciones
- **AnimationController** con máquina de estados
- Animaciones implementadas:
  - Idle (Reposo)
  - Walk (Caminar)
  - Run (Correr)
  - Jump (Saltar)
- Transiciones suaves entre estados
- Sincronización automática con velocidad del jugador

---

## ✅ Entrada de Datos

### Teclado + Ratón
- **WASD** - Movimiento
- **Espacio** - Saltar
- **Mayúscula** - Correr
- **Ratón** - Mirar alrededor (capturado automáticamente)
- **Esc** - Abrir menú de pausa

### Controlador Xbox
- **Stick Izquierdo** - Movimiento
- **Stick Derecho** - Mirar alrededor
- **Botón A** - Saltar
- **LB/RB** - Correr
- Sensibilidades independientes

---

## ✅ Interfaz de Usuario

### Menú Principal
- **MenuController.gd** - Control del menú principal
- Botones interactivos con animaciones de hover
- Escalado y cambio de color al pasar el ratón
- Animaciones suaves en presionar

### Menú de Pausa
- **PauseController.gd** - Gestión de pausa
- Accesible presionando Esc durante el juego
- Opción para reanudar o salir

### Menú de Opciones
- **OptionsController.gd** - Configuración del juego
- **OptionsMenuPausaController.gd** - Opciones desde menú de pausa
- Interfaz de configuración

### HUD en Juego
- **HUDController.gd** - Pantalla de información
- Contador de coleccionables en la esquina superior derecha
- Actualización en tiempo real

---

## ✅ Sistema de Coleccionables

### CollectibleManager (Autoload)
- **Gestor global** de coleccionables
- Seguimiento de coleccionables recogidos
- Sistema de señales (signals)
- `collectible_picked(total_count)` - Se emite al recoger un coleccionable
- Métodos:
  - `pick_collectible()` - Registrar coleccionable recogido
  - `get_total()` - Obtener total recogido
  - `reset()` - Reiniciar contador

### CollectibleController.gd
- Controla objetos coleccionables individuales
- Notifica al CollectibleManager cuando se recoge
- Desaparece al ser recogido

### Escena Coleccionable
- **Collectible.tscn** - Prefab de coleccionable
- Modelo 3D con física
- Detección de colisiones

---

## ✅ Gestión de Niveles

### MainLevel.gd
- **Gestor del nivel principal**
- Inicialización del nivel
- Detección de caída del jugador (cae debajo de y = -10)
- Reaparición automática del jugador en posición inicial
- Reinicio de velocidad

### Nivel Principal (main.tscn)
- Plataforma de tierra principal
- Dos plataformas elevadas para saltar
- Sistema de iluminación con sombras
- Iluminación ambiental para visibilidad
- Cielo y entorno básico

---

## ✅ Modelos 3D

### Assets de Modelos
- **knight.blend** - Modelo del personaje principal
- **shield.blend** - Escudo (asset preparado)
- **sword.blend** - Espada (asset preparado)

---

## ✅ Configuración del Proyecto

### project.godot
- Versión de Godot: 4.6+
- Renderer: GL Compatibility
- Escena principal: Menu.tscn (menú inicial)
- Mapa de entrada completamente configurado
- AutoLoad: CollectibleManager
- Icono del proyecto configurado

### Mapa de Entrada (Input Map)
Todas las acciones configuradas con teclas y controles de gamepad:
- `move_forward` - W + Stick arriba
- `move_backward` - S + Stick abajo
- `move_left` - A + Stick izquierda
- `move_right` - D + Stick derecha
- `jump` - Espacio + Botón A
- `run` - Mayúscula + LB/RB
- `camera_right` - Ratón derecha + Stick derecha
- `camera_left` - Ratón izquierda + Stick izquierda
- `camera_up` - Ratón arriba + Stick arriba
- `camera_down` - Ratón abajo + Stick abajo

---

## 📁 Estructura de Archivos

```
scripts/
├── player/
│   ├── PlayerController.gd ........... Control de movimiento y física
│   ├── CameraController.gd ........... Cámara en tercera persona
│   └── AnimationController.gd ........ Máquina de estados de animación
├── managers/
│   └── MainLevel.gd ................. Gestor del nivel
├── autoload/
│   └── CollectibleManager.gd ........ Gestor global de coleccionables
├── objects/
│   └── CollectibleController.gd ..... Control de coleccionables
└── ui/
    ├── MenuController.gd ............ Control del menú principal
    ├── PauseController.gd ........... Control del menú de pausa
    ├── OptionsController.gd ......... Control de opciones
    ├── OptionsMenuPausaController.gd  Opciones desde pausa
    └── HUDController.gd ............ Interfaz en juego

scenes/
├── player/
│   └── Player.tscn ................. Escena del jugador
├── levels/
│   └── main.tscn ................... Nivel principal
├── objects/
│   └── Collectible.tscn ............ Prefab de coleccionable
└── ui/
    ├── Menu.tscn ................... Menú principal
    ├── PauseMenu.tscn .............. Menú de pausa
    ├── OptionsMenu.tscn ............ Menú de opciones
    ├── OptionsMenuPausa.tscn ....... Opciones desde pausa
    └── HUD.tscn ................... Interfaz en juego

assets/
├── models/
│   ├── knight.blend (+ .import)
│   ├── shield.blend (+ .import)
│   └── sword.blend (+ .import)
├── audio/
├── fonts/
├── images/
└── materials/
```

---

## 🎮 Flujo de Juego

1. **Inicio:** Se carga Menu.tscn (menú principal)
2. **Menú:** Usuario selecciona Play
3. **Juego:** Se carga main.tscn con el Player
4. **Gameplay:**
   - Movimiento con WASD/Stick izquierdo
   - Mirar con ratón/Stick derecho
   - Saltar con Espacio/Botón A
   - Correr con Mayúscula/LB/RB
   - Recoger coleccionables
   - Si cae, reaparece en posición inicial
5. **Pausa:** Presionar Esc para abrir menú de pausa
6. **Menú:** Opción de reanudar o salir

---

## 🔧 Parámetros Personalizables

Todos estos valores pueden ajustarse en el inspector de Godot:

### PlayerController
- `max_walk_speed` - Velocidad de caminata
- `max_run_speed` - Velocidad de carrera
- `acceleration` - Aceleración del movimiento
- `friction` - Fricción al detener
- `gravity` - Fuerza de la gravedad
- `jump_force` - Altura del salto

### CameraController
- `distance` - Distancia de la cámara
- `height` - Altura de la cámara
- `mouse_sensitivity` - Sensibilidad del ratón
- `gamepad_sensitivity` - Sensibilidad del gamepad
- `min_pitch` / `max_pitch` - Rango vertical de la cámara
- `orbit_speed` - Velocidad de rotación orbital

---

## ✨ Características Listas para Usar

- ✅ Movimiento 3D fluido
- ✅ Cámara en tercera persona
- ✅ Sistema de animaciones
- ✅ Menú principal funcional
- ✅ Menú de pausa
- ✅ Sistema de coleccionables
- ✅ HUD básico
- ✅ Entrada multijugador (teclado + gamepad)
- ✅ Física realista
- ✅ Iluminación y sombras
- ✅ Reaparición del jugador

---

## 🚀 Listo para Expandir

- Enemy system (estructura preparada en `scripts/enemies/`)
- Más niveles (estructura preparada en `scenes/levels/`)
- Más objetos del mundo (estructura preparada en `scripts/objects/`)
- Sistema de combate
- Sistema de puntuación avanzado
- Efectos de sonido y música
- Nuevas mecánicas de juego

---

**Versión:** Alpha 0.0.1  
**Godot:** 4.6+  
**Última actualización:** 9 de Abril de 2026
