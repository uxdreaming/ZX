# ZX — Qtile Setup

Configuración completa de un entorno de escritorio basado en **Qtile** sobre **Linux Mint 22.3** (o cualquier distro basada en Ubuntu/Debian).

Incluye tema Tokyo Night Moon, dictado por voz local, fuentes Nerd Fonts y herramientas de terminal.

---

## Instalación rápida

```bash
git clone https://github.com/uxdreaming/ZX.git
cd ZX
bash install.sh
```

El script instala y configura todo automáticamente. Al terminar, cerrá sesión y elegí **Qtile** en LightDM.

---

## Estructura del repo

```
ZX/
├── install.sh              # Script de instalación completo
├── config/
│   ├── qtile/
│   │   └── config.py       # Configuración principal de Qtile
│   ├── alacritty/
│   │   └── alacritty.toml  # Terminal con Tokyo Night
│   ├── xsettingsd/
│   │   └── xsettingsd.conf # Tema GTK para apps en Qtile
│   ├── gtk-3.0/
│   │   └── settings.ini
│   ├── gtk-4.0/
│   │   └── settings.ini
│   └── dict/
│       └── config.json     # Config del dictado por voz
└── README.md
```

---

## Qué instala el script

| Componente | Detalle |
|------------|---------|
| **Qtile 0.35+** | WM tiling vía pipx |
| **Alacritty** | Terminal GPU-accelerated |
| **Rofi** | Lanzador de apps |
| **Thunar** | Gestor de archivos |
| **Tokyo Night Moon** | Tema GTK dark suave |
| **Papirus Dark** | Iconos |
| **CaskaydiaCove NF** | Fuente Nerd Font para terminal |
| **xsettingsd** | Aplica temas GTK sin GNOME/KDE |
| **Dict** | Dictado por voz local (faster-whisper) |
| **playerctl** | Control de audio para keybindings |
| **autorandr** | Perfiles de pantalla automáticos |
| **tty-clock, cava, pipes, nms, nitrogen** | Herramientas de terminal |

---

## Keybindings

### Apps

| Atajo | Acción |
|-------|--------|
| `Super + Enter` | Terminal (Alacritty) |
| `Super + D` | Rofi — apps |
| `Super + Shift + W` | Google Chrome |
| `Super + Shift + D` | Thunar |
| `Super + L` | Bloquear pantalla |
| `F4` | Dict — dictado por voz |

### Ventanas

| Atajo | Acción |
|-------|--------|
| `Super + Alt` | Ciclar foco entre ventanas |
| `Super + ←↑↓→` | Mover foco |
| `Super + Shift + ←↑↓→` | Mover ventana |
| `Super + Shift + Space` | Alternar flotante |
| `Super + W / C` | Cerrar ventana |

### Workspaces y layouts

| Atajo | Acción |
|-------|--------|
| `Alt + Tab` | Alternar entre últimos dos workspaces |
| `Super + Tab` | Ciclar workspaces con ventanas |
| `Super + Shift + Tab` | Ciclar entre layouts |
| `Super + 0–9` | Ir al workspace |
| `Super + Shift + 0–9` | Mover ventana al workspace |
| `Super + Numpad 0–9` (sin NumLock) | Ir al workspace |

### Audio (teclado numérico)

| Atajo | Acción |
|-------|--------|
| `Alt + /` | Bajar volumen 5% |
| `Alt + *` | Subir volumen 5% |
| `Alt + -` | Mute/Unmute |
| `Alt + +` | Play/Pause |

### Sistema

| Atajo | Acción |
|-------|--------|
| `Super + Ctrl + R` | Recargar config |
| `Super + Ctrl + Q` | Salir de Qtile |

---

## Layouts

4 layouts ciclables con `Super + Shift + Tab`:

| Layout | Descripción |
|--------|-------------|
| **Columns** | Múltiples columnas |
| **Max** | Pantalla completa |
| **MonadTall** | Principal izquierda, resto apiladas derecha |
| **MonadWide** | Principal arriba, resto apiladas abajo |

---

## Dict — Dictado por voz

Transcripción local con **faster-whisper**, sin internet ni API externa.

- **Doble RCtrl** → grabar / transcribir y pegar
- **RAlt** → pausar / reanudar
- Idiomas: español (principal) + inglés
- Modelo: `small` (~460MB, descarga en primera ejecución)

Config en `~/.config/dict/config.json`.

---

## Aliases

```bash
alias c='clear'
alias x='exit'
```

---

## Herramientas de terminal

| Comando | Descripción |
|---------|-------------|
| `tty-clock` | Reloj |
| `cava` | Visualizador de audio |
| `pipes` | Pipes animados |
| `nms` | Efecto descifrado (Sneakers) |
| `nitrogen` | Fondos de escritorio |
