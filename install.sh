#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="$HOME"

echo ""
echo "═══════════════════════════════════════"
echo "   ZX — Instalación de entorno Qtile   "
echo "═══════════════════════════════════════"
echo ""

# ── 1. Paquetes del sistema ───────────────────────────────────────────────────
echo "[1/8] Instalando paquetes del sistema..."
sudo apt update -q
sudo apt install -y \
  python3-pip python3-dev pipx \
  libpangocairo-1.0-0 python3-xcffib python3-cairocffi \
  python3-dbus python3-gi python3-psutil \
  xserver-xorg xinit xsettingsd sassc \
  alacritty rofi thunar \
  papirus-icon-theme \
  xdotool xclip wmctrl portaudio19-dev python3-venv \
  playerctl \
  tty-clock cava pipes-sh nitrogen \
  build-essential libncurses-dev \
  autorandr

# ── 2. Qtile ─────────────────────────────────────────────────────────────────
echo "[2/8] Instalando Qtile..."
pipx install qtile

# ── 3. Registro en LightDM ────────────────────────────────────────────────────
echo "[3/8] Registrando Qtile en LightDM..."
sudo tee /usr/share/xsessions/qtile.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=Qtile
Comment=Qtile Window Manager
Exec=/home/aru/.local/bin/qtile start
Type=Application
Keywords=wm;tiling
EOF

# ── 4. Configs ────────────────────────────────────────────────────────────────
echo "[4/8] Copiando configuraciones..."
mkdir -p ~/.config/qtile ~/.config/alacritty ~/.config/xsettingsd \
         ~/.config/gtk-3.0 ~/.config/gtk-4.0 ~/.config/dict

cp "$REPO_DIR/config/qtile/config.py"           ~/.config/qtile/config.py
cp "$REPO_DIR/config/alacritty/alacritty.toml"  ~/.config/alacritty/alacritty.toml
cp "$REPO_DIR/config/xsettingsd/xsettingsd.conf" ~/.config/xsettingsd/xsettingsd.conf
cp "$REPO_DIR/config/gtk-3.0/settings.ini"      ~/.config/gtk-3.0/settings.ini
cp "$REPO_DIR/config/gtk-4.0/settings.ini"      ~/.config/gtk-4.0/settings.ini
cp "$REPO_DIR/config/dict/config.json"           ~/.config/dict/config.json

# ── 5. Fuente CaskaydiaCove Nerd Font ─────────────────────────────────────────
echo "[5/8] Instalando CaskaydiaCove Nerd Font..."
mkdir -p ~/.local/share/fonts
cd /tmp
curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip" -o CascadiaCode.zip
unzip -q -o CascadiaCode.zip -d CascadiaCode
cp CascadiaCode/*.ttf ~/.local/share/fonts/
fc-cache -fv ~/.local/share/fonts > /dev/null 2>&1
cd "$REPO_DIR"

# ── 6. Tokyo Night GTK Theme ─────────────────────────────────────────────────
echo "[6/8] Instalando tema Tokyo Night Moon..."
mkdir -p ~/.themes
cd /tmp
curl -sL "https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme/archive/refs/heads/master.zip" -o tokyo-night.zip
unzip -q -o tokyo-night.zip
cd Tokyonight-GTK-Theme-master/themes
bash install.sh -c dark -s standard --tweaks moon -d ~/.themes
cd "$REPO_DIR"
gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark-Moon'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# ── 7. Dict ───────────────────────────────────────────────────────────────────
echo "[7/8] Instalando Dict..."
mkdir -p ~/apps/dict/src
cd ~/apps/dict
curl -sO https://raw.githubusercontent.com/uxdreaming/Qtile/main/dict/requirements.txt
curl -sO https://raw.githubusercontent.com/uxdreaming/Qtile/main/dict/main.py
curl -sO https://raw.githubusercontent.com/uxdreaming/Qtile/main/dict/setup.sh
curl -sO https://raw.githubusercontent.com/uxdreaming/Qtile/main/dict/launch.sh
for f in __init__ audio config hotkeys improver paster state transcriber widget; do
  curl -s "https://raw.githubusercontent.com/uxdreaming/Qtile/main/dict/src/${f}.py" -o "src/${f}.py"
done
bash setup.sh

cat > ~/apps/dict/run.sh << 'EOF'
#!/bin/bash
pkill -f "python.*main.py" 2>/dev/null
sleep 0.3
cd /home/aru/apps/dict
/home/aru/apps/dict/venv/bin/python -u main.py >> /tmp/dict.log 2>&1 &
EOF
chmod +x ~/apps/dict/run.sh
cd "$REPO_DIR"

# ── 8. no-more-secrets ────────────────────────────────────────────────────────
echo "[8/8] Instalando no-more-secrets..."
cd /tmp
git clone https://github.com/bartobri/no-more-secrets.git 2>/dev/null || true
cd no-more-secrets && make && sudo make install
cd "$REPO_DIR"

# ── Aliases ───────────────────────────────────────────────────────────────────
grep -qxF "alias c='clear'" ~/.bashrc || echo "alias c='clear'" >> ~/.bashrc
grep -qxF "alias x='exit'"  ~/.bashrc || echo "alias x='exit'"  >> ~/.bashrc

echo ""
echo "═══════════════════════════════════════"
echo "   ✓ Instalación completa              "
echo "   → Cerrá sesión y elegí Qtile        "
echo "═══════════════════════════════════════"
echo ""
