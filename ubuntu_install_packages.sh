#!/bin/bash

set -eu

# =================================================================================
# A script to automate the setup of a new Ubuntu Desktop installation.
# =================================================================================

# --- APT Packages List ---
APT_PACKAGES="
  build-essential
  curl
  git
  vim
  htop
  wget
  zsh
  jq
  unzip
  devscripts
  ipcalc
  openvpn
  ripgrep
  sshuttle
  tmux
"
PPA_APT_PACKAGES="
  syncthing
  tailscale
"
DESKTOP_APT_PACKAGES="
  gnome-tweaks
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
sudo snap install juju
sudo snap install terraform --classic

# --- Enable syncthing ---
sudo systemctl enable syncthing@${USER}.service
sudo systemctl start syncthing@${USER}.service

# --- Install starship ---
curl -sS https://starship.rs/install.sh | sh

# --- Desktop specific ---
if [ -n "$DISPLAY" ]; then
  sudo apt update && sudo apt install -y $DESKTOP_APT_PACKAGES
  sudo snap install code --classic
fi

# --- Final Clean-up ---
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

echo "========================================"
echo "✅ Setup complete! Please reboot your system."
echo "========================================"