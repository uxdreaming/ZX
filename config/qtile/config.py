import subprocess
from libqtile import hook, layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

@hook.subscribe.startup_once
def autostart():
    subprocess.Popen(["xsettingsd"])
    subprocess.Popen(["xsetroot", "-solid", "#101010"])

mod = "mod4"  # Tecla Super (Windows)
terminal = "alacritty"

# ── Tokyo Night ───────────────────────────────────────────────────────────────
TN = {
    "bg":      "#1f2335",
    "bg_dark": "#1a1b2e",
    "fg":      "#c0caf5",
    "blue":    "#7aa2f7",
    "cyan":    "#7dcfff",
    "green":   "#9ece6a",
    "red":     "#f7768e",
    "yellow":  "#e0af68",
    "purple":  "#bb9af7",
    "gray":    "#3b4261",
    "comment": "#565f89",
}

# ── Keybindings ───────────────────────────────────────────────────────────────
keys = [
    # Foco entre ventanas
    Key([mod], "Alt_L", lazy.layout.next()),

    # Apps
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "l", lazy.spawn("dm-tool lock")),
    Key([], "F4", lazy.spawn("bash /home/aru/apps/dict/run.sh")),
    Key([mod, "shift"], "w", lazy.spawn("google-chrome")),
    Key([mod, "shift"], "d", lazy.spawn("thunar")),
    Key([mod], "d", lazy.spawn("rofi -show drun")),
    Key([mod], "r", lazy.spawn("rofi -show drun")),
    Key([mod, "shift"], "r", lazy.spawn("rofi -show run")),

    # Mover foco entre ventanas
    Key([mod], "Left",  lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Up",    lazy.layout.up()),
    Key([mod], "Down",  lazy.layout.down()),

    # Mover ventanas
    Key([mod, "shift"], "Left",  lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "Up",    lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down",  lazy.layout.shuffle_down()),

    # Navegación de workspaces y layouts
    Key(["mod1"], "Tab", lazy.screen.toggle_group()),
    Key([mod], "Tab", lazy.screen.next_group(skip_empty=True)),
    Key([mod, "shift"], "Tab", lazy.next_layout()),

    # Ventanas
    Key([mod], "w", lazy.window.kill()),
    Key([mod], "c", lazy.window.kill()),
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),

    # Audio (Alt + teclado numérico)
    Key(["mod1"], "KP_Divide",   lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key(["mod1"], "KP_Multiply", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key(["mod1"], "KP_Subtract", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key(["mod1"], "KP_Add",      lazy.spawn("playerctl play-pause")),

    # Qtile
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown()),
]

# ── Grupos ────────────────────────────────────────────────────────────────────
groups = [Group(i) for i in "0123456789"]

# Numpad sin NumLock: KP_Insert=0, KP_End=1, KP_Down=2, KP_Next=3,
#                     KP_Left=4,   KP_Begin=5, KP_Right=6,
#                     KP_Home=7,   KP_Up=8,    KP_Prior=9
numpad_keys = [
    "KP_Insert",
    "KP_End", "KP_Down", "KP_Next",
    "KP_Left", "KP_Begin", "KP_Right",
    "KP_Home", "KP_Up", "KP_Prior",
]

for g, kp in zip(groups, numpad_keys):
    keys.extend([
        Key([mod], g.name, lazy.group[g.name].toscreen()),
        Key([mod, "shift"], g.name, lazy.window.togroup(g.name)),
        Key([mod], kp, lazy.group[g.name].toscreen()),
        Key([mod, "shift"], kp, lazy.window.togroup(g.name)),
    ])

# ── Layouts ───────────────────────────────────────────────────────────────────
layouts = [
    layout.Columns(
        border_focus=TN["blue"],
        border_normal=TN["gray"],
        border_width=2,
        margin=6,
    ),
    layout.Max(),
    layout.MonadTall(
        border_focus=TN["blue"],
        border_normal=TN["gray"],
        border_width=2,
        margin=6,
    ),
    layout.MonadWide(
        border_focus=TN["blue"],
        border_normal=TN["gray"],
        border_width=2,
        margin=6,
    ),
]

screens = [Screen()]

# ── Mouse ─────────────────────────────────────────────────────────────────────
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# ── Misc ──────────────────────────────────────────────────────────────────────
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_keep_above = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"
