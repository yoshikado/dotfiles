#!/bin/bash

# A script to automate the installation of a Nerd Font on Ubuntu.

# --- CONFIGURATION ---
# The Nerd Fonts version to install. Check the releases page for the latest version:
# https://github.com/ryanoasis/nerd-fonts/releases
NERD_FONT_VERSION="3.4.0"
# The directory to install the fonts to.
# ~/.local/share/fonts is the standard for user-specific fonts.
FONT_DIR="$HOME/.local/share/fonts"

# --- SCRIPT LOGIC ---
# Check if a font name was provided.
if [ -z "$1" ]; then
  echo "Usage: ./install-nerd-font.sh <FontName>"
  echo "Example: ./install-nerd-font.sh FiraCode"
  exit 1
fi

FONT_NAME=$1
echo "Installing Nerd Font: $FONT_NAME"

# Create the font directory if it doesn't exist.
mkdir -p "$FONT_DIR"

# Define the download URL and the destination file path.
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONT_VERSION}/${FONT_NAME}.zip"
ZIP_FILE="/tmp/${FONT_NAME}.zip"

# Download the font zip file.
echo "Downloading from $DOWNLOAD_URL..."
wget -q --show-progress -O "$ZIP_FILE" "$DOWNLOAD_URL"

# Check if the download was successful.
if [ $? -ne 0 ]; then
  echo "Error: Download failed. Check if the font name '$FONT_NAME' and version 'v$NERD_FONT_VERSION' are correct."
  exit 1
fi

# Unzip the font file into the font directory.
echo "Extracting to $FONT_DIR..."
unzip -o "$ZIP_FILE" -d "$FONT_DIR" > /dev/null

# Clean up the downloaded zip file.
rm "$ZIP_FILE"

# Rebuild the font cache.
echo "Updating font cache..."
fc-cache -fv > /dev/null

echo "✅ Done! The '$FONT_NAME' Nerd Font has been installed."