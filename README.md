# glava_zenxlk

Mi configuración personal de [GLava](https://github.com/jarcode-foss/glava) (visualizador de espectro de audio en OpenGL), corriendo en Arch Linux + [Hyprland](https://hyprland.org/) usando [HyDE](https://github.com/HyDE-Project/HyDE).

Usa el módulo **radial** (barras circulares) en vez del `bars` por defecto, con el color de las barras sincronizado automáticamente al wallpaper actual vía [Wallbash](https://github.com/HyDE-Project/HyDE) (el sistema de paletas dinámicas de HyDE) — el mismo acento (`wallbash_pry4`) que uso en los bordes de split de [kitty_zenxlk](https://github.com/Zenxlk/kitty_zenxlk).

## Estructura

```
.config/
├── glava/
│   ├── rc.glsl                 # Entry point: módulo activo = "radial", geometría de ventana, fuente de audio...
│   ├── radial.glsl             # Config del módulo radial: radio, grosor de barras, y el color dinámico
│   ├── wallbash_colors.glsl    # Snapshot de los colores actuales (ver nota abajo, no es la fuente de verdad)
│   ├── smooth_parameters.glsl  # Suavizado por defecto de GLava (sin modificar)
│   ├── bars.glsl / circle.glsl / graph.glsl / wave.glsl / env_*.glsl  # Resto de configs por defecto, por si se quiere cambiar de módulo
└── hyde/
    └── wallbash/
        ├── always/glava.dcol     # Template de wallbash: genera wallbash_colors.glsl en cada cambio de tema/wallpaper
        └── scripts/glava.sh      # Post-comando del template: reinicia GLava (si esta corriendo) para que tome el color nuevo
```

**Nota sobre `wallbash_colors.glsl`:** este archivo lo regenera Wallbash automáticamente (vía `glava.dcol`) cada vez que cambias de wallpaper o de tema — lo que está en este repo es solo una foto del color activo al momento del commit, para que el repo sea usable tal cual aunque no tengas Wallbash corriendo. La fuente de verdad es el template `glava.dcol`.

## Instalación

GLava no está en los repos oficiales de Arch, solo en el AUR:

```bash
yay -S glava
```

Copia la configuración de este repo:

```bash
git clone https://github.com/Zenxlk/glava_zenxlk.git
cp -r glava_zenxlk/.config/glava ~/.config/
cp -r glava_zenxlk/.config/hyde/wallbash/always/glava.dcol ~/.config/hyde/wallbash/always/
cp -r glava_zenxlk/.config/hyde/wallbash/scripts/glava.sh ~/.config/hyde/wallbash/scripts/
chmod +x ~/.config/hyde/wallbash/scripts/glava.sh
```

Lanzar como widget de escritorio:

```bash
glava -d &
```

### Si no usas HyDE/Wallbash

El include `#include ":wallbash_colors.glsl"` en `radial.glsl` y el color `vec3(wallbash_pry4)` solo funcionan si existe `~/.config/glava/wallbash_colors.glsl` con esas macros definidas (lo genera Wallbash). Sin HyDE, borra esa línea de include y cambia la macro `COLOR` por un color fijo, por ejemplo:

```glsl
#define COLOR (#cc3333 * ((d / 40) + 1))
```

## Características

- Módulo **radial**: barras dispuestas en círculo alrededor de un anillo central, en vez de barras rectas
- Color de las barras 100% dinámico vía un template propio de Wallbash (`glava.dcol`), igual que los bordes de kitty — cambia de wallpaper y las barras cambian de color solas
- GLava se reinicia automáticamente (si está corriendo) cada vez que cambia el wallpaper, para recargar el color nuevo — ver `glava.sh`

## Licencia

Siéntete libre de usar y adaptar cualquier parte de esta configuración.
