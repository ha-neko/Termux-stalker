#!/usr/bin/env bash
set -e

echo "☢️ STALKER TERMUX SETUP ☢️"

# Create all necessary directories including .termux
mkdir -p ~/.config/fish ~/.config/fastfetch ~/.termux/fonts ~/.termux

echo "[+] Copying configs..."
cp -f fish/config.fish ~/.config/fish/config.fish
cp -f fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
cp -f fastfetch/radiation.txt ~/.config/fastfetch/radiation.txt
cp -f stalker_ascii.txt ~/.config/stalker_ascii.txt
cp -f starship.toml ~/.config/starship.toml

echo "[+] Configuring Catppuccin Mocha color theme..."
cat << 'EOF' > ~/.termux/colors.properties
background = #1e1e2e
foreground = #cdd6f4
cursor = #f5e0dc

# Black + Gray
color0 = #45475a
color8 = #585b70

# Red
color1 = #f38ba8
color9 = #f38ba8

# Green
color2 = #a6e3a1
color10 = #a6e3a1

# Yellow
color3 = #f9e2af
color11 = #f9e2af

# Blue
color4 = #89b4fa
color12 = #89b4fa

# Magenta / Pink
color5 = #f5c2e7
color13 = #f5c2e7

# Cyan / Teal
color6 = #94e2d5
color14 = #94e2d5

# White
color7 = #bac2de
color15 = #a6adc8
EOF

echo "[+] Removing default Termux greeting (MOTD)..."
touch ~/.hushlogin
rm -f $PREFIX/etc/motd
rm -f $PREFIX/etc/motd.d/* 2>/dev/null || true


echo "[+] Installing packages..."
pkg update -y
pkg install -y fish starship fastfetch wget unzip


# --- NERD FONT CHECK ---
if [ -f "$HOME/.termux/font.ttf" ]; then
  echo "[=] JetBrains Mono Nerd Font is already installed. Skipping download..."
else
  echo "[+] Installing JetBrains Mono Nerd Font..."

  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
  TEMP_DIR="$(mktemp -d)"

  cd "$TEMP_DIR"
  wget -q --show-progress "$FONT_URL" -O JetBrainsMono.zip
  unzip -q JetBrainsMono.zip

  # Clean existing fonts (IMPORTANT)
  rm -f ~/.termux/fonts/*
  rm -f ~/.termux/font.ttf

  # Copy ONLY the correct Nerd Font (Regular)
  cp JetBrainsMonoNerdFont-Regular.ttf ~/.termux/font.ttf

  cd ~
  rm -rf "$TEMP_DIR"

  echo "[+] Font installed: JetBrainsMono Nerd Font (Regular)"
fi
# -----------------------


# Reload Termux settings (font + colors reload)
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
