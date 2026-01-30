#!/usr/bin/env bash
set -e

echo "☢️ STALKER TERMUX SETUP ☢️"

mkdir -p ~/.config/fish ~/.config/fastfetch ~/.termux/fonts

echo "[+] Copying configs..."
cp -f fish/config.fish ~/.config/fish/config.fish
cp -f fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
cp -f fastfetch/radiation.txt ~/.config/fastfetch/radiation.txt
cp -f stalker_ascii.txt ~/.config/stalker_ascii.txt
cp -f starship.toml ~/.config/starship.toml

echo "[+] Removing default Termux greeting (MOTD)..."
touch ~/.hushlogin
rm -f $PREFIX/etc/motd
rm -f $PREFIX/etc/motd.d/* 2>/dev/null || true


echo "[+] Installing packages..."
pkg update -y
pkg install -y fish starship fastfetch wget unzip


echo "[+] Installing JetBrains Mono Nerd Font..."

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
TEMP_DIR="$(mktemp -d)"

cd "$TEMP_DIR"
wget -q --show-progress "$FONT_URL" -O JetBrainsMono.zip
unzip -q JetBrainsMono.zip

# Clean existing fonts (IMPORTANT)
rm -f ~/.termux/fonts/*

# Copy ONLY the correct Nerd Font (Regular)
cp JetBrainsMonoNerdFont-Regular.ttf ~/.termux/fonts/

cd ~
rm -rf "$TEMP_DIR"

echo "[+] Font installed: JetBrainsMono Nerd Font (Regular)"

# Reload Termux settings (font reload)
if command -v termux-reload-settings >/dev/null 2>&1; then
  termux-reload-settings
fi


echo "[+] Ensuring Fish + Starship compatibility..."

FISH_CONFIG="$HOME/.config/fish/config.fish"

# Add Starship init only if missing
if ! grep -q "starship init fish" "$FISH_CONFIG"; then
  cat >> "$FISH_CONFIG" <<'EOF'


sleep 0.05
starship init fish | source
EOF
fi


echo "[+] Setting fish as default shell..."
chsh -s fish || true


echo " YOU MAY RESTART TERMUX"
echo "✔ SETUP COMPLETE"

