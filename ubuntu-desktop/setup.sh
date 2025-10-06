#!/bin/bash

set -eu

# =================================================================================
# A script to automate the setup of a new Ubuntu Desktop installation.
# =================================================================================

# --- APT Packages List ---
# Define all packages in a single variable for easy management.
APT_PACKAGES="
  build-essential
  curl
  git
  vim
  htop
  gnome-tweaks
  wget
  zsh
  jq
  unzip
  devscripts
  ipcalc
  openvpn
  ripgrep
  sshuttle
"
PPA_APT_PACKAGES="
  syncthing
  tailscale
"

UBUNTU_RELEASE=$(lsb_release -sc)

# --- Update and Upgrade System ---
echo "Updating package lists and upgrading system..."
sudo apt update && sudo apt upgrade -y

# --- Install APT packages ---
echo "Installing APT packages..."
sudo apt install -y $APT_PACKAGES

# --- Add PPAs ---
curl -fsSL https://syncthing.net/release-key.gpg | sudo tee /usr/share/keyrings/syncthing-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/${UBUNTU_RELEASE}.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/${UBUNTU_RELEASE}.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

# --- Install PPA APT packages ---
echo "Installing PPA APT packages..."
sudo apt update && sudo apt install -y $PPA_APT_PACKAGES

# --- Install Apps with Snap ---
# Snaps are great for installing modern apps like VS Code, Spotify, etc.
echo "Installing Snap packages..."
sudo snap install code --classic

# --- Enable syncthing ---
sudo systemctl enable syncthing@${USER}.service
sudo systemctl start syncthing@${USER}.service

# --- System Configuration with gsettings ---
# You can change many GNOME settings from the command line.
echo "Configuring GNOME settings..."
# Example: Move the dock to the bottom.
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
# Example: Enable minimize on click for the dock.
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# --- Final Clean-up ---
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

echo "========================================"
echo "✅ Setup complete! Please reboot your system."
echo "========================================"