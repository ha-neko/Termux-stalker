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

echo "[+] Downloading JetBrains Mono font..."
FONT_VERSION="2.304"
FONT_URL="https://github.com/JetBrains/JetBrainsMono/releases/download/v${FONT_VERSION}/JetBrainsMono-${FONT_VERSION}.zip"
TEMP_DIR=$(mktemp -d)

cd "$TEMP_DIR"
wget -q --show-progress "$FONT_URL" -O JetBrainsMono.zip

echo "[+] Extracting font..."
unzip -q JetBrainsMono.zip

# Create fonts directory if it doesn't exist
mkdir -p ~/.termux/fonts

# Copy only TTF files from the fonts/ttf directory
if [ -d "fonts/ttf" ]; then
    cp fonts/ttf/*.ttf ~/.termux/fonts/
    echo "[+] JetBrains Mono font installed to ~/.termux/fonts/"
else
    echo "[!] Warning: fonts/ttf directory not found in zip"
fi

# Clean up
cd ~
rm -rf "$TEMP_DIR"

echo "[+] Setting fish as default shell..."
chsh -s fish || true

echo ""
echo "✔ SETUP COMPLETE"
echo ""
echo "📝 Next steps:"
echo "   1. Restart Termux to enter the Zone ☢️"
echo "   2. Long-press on Termux screen → Settings → Font"
echo "   3. Select 'JetBrains Mono' from the font list"
echo ""