#!/usr/bin/env bash
set -e

echo "☢️ STALKER TERMUX SETUP ☢️"

# Ensure config dirs
mkdir -p ~/.config/fish ~/.config/fastfetch

echo "[+] Copying configs..."

cp -f fish/config.fish ~/.config/fish/config.fish
cp -f fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
cp -f fastfetch/radiation.txt ~/.config/fastfetch/radiation.txt
cp -f stalker_ascii.txt ~/.config/stalker_ascii.txt
cp -f starship.toml ~/.config/starship.toml

echo "[+] Removing default Termux greeting (MOTD)..."

# Disable default Termux welcome message
touch ~/.hushlogin

# Remove static motd if exists
rm -f $PREFIX/etc/motd
rm -f $PREFIX/etc/motd.d/* 2>/dev/null || true

echo "[+] Installing packages..."
pkg update -y
pkg install -y fish starship fastfetch

echo "[+] Setting fish as default shell..."
chsh -s fish || true

echo "✔ SETUP COMPLETE"
echo "Restart Termux to enter the Zone ☢️"

