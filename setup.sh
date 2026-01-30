#!/usr/bin/env bash
set -e

echo "☢️ STALKER TERMUX SETUP ☢️"

# Ensure config dirs
mkdir -p ~/.config/fish ~/.config/fastfetch ~/.termux

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
pkg install -y fish starship fastfetch wget unzip

echo "[+] Downloading JetBrains Mono Nerd Font..."
# Use Nerd Fonts repository instead of JetBrains official
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
TEMP_DIR=$(mktemp -d)

cd "$TEMP_DIR"
wget -q --show-progress "$FONT_URL" -O JetBrainsMono.zip

echo "[+] Extracting Nerd Font..."
unzip -q JetBrainsMono.zip

# Create fonts directory if it doesn't exist
mkdir -p ~/.termux/fonts

# Copy TTF files (Nerd Fonts zip has TTF files in root)
cp *.ttf ~/.termux/fonts/ 2>/dev/null || echo "[!] Note: Some font files might already exist"
echo "[+] JetBrains Mono Nerd Font installed to ~/.termux/fonts/"

# Clean up
cd ~
rm -rf "$TEMP_DIR"

echo "[+] Setting fish as default shell..."
chsh -s fish || true

echo ""
echo "✔ SETUP COMPLETE"
echo ""
echo "📝 IMPORTANT - Final steps:"
echo "   1. Restart Termux (close and reopen the app)"
echo "   2. Long-press on Termux screen → Settings → Font"
echo "   3. Select 'JetBrainsMono Nerd Font' (NOT regular JetBrains Mono)"
echo "   4. Restart Termux again to see all icons properly"
echo ""
echo "   If icons still don't show, see TROUBLESHOOTING.md"
echo ""