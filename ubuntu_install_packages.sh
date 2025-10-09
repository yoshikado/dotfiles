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
  virtualenv
  lm-sensors
"
PPA_APT_PACKAGES="
  syncthing
  tailscale
"
DESKTOP_APT_PACKAGES="
  gnome-tweaks
  gnome-shell-extensions
  gnome-shell-extension-manager
  mattermost-desktop
  ibus-mozc
  mozc-utils-gui
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
curl -fsS -o- https://deb.packages.mattermost.com/setup-repo.sh | sudo UPDATE_GPG_KEY=yes bash

# --- Install PPA APT packages ---
echo "Installing PPA APT packages..."
sudo apt update && sudo apt install -y $PPA_APT_PACKAGES

# --- Install Apps with Snap ---
echo "Installing Snap packages..."
sudo snap install juju
sudo snap install terraform --classic
sudo snap install google-cloud-cli --classic
sudo snap install go --classic

# --- Install Go packages ---
go install github.com/x-motemen/ghq@latest

# --- Enable syncthing service ---
sudo systemctl enable syncthing@${USER}.service
sudo systemctl start syncthing@${USER}.service

# --- Install non-package applications ---
curl -sS https://starship.rs/install.sh | sh -s -- -y
if [ -e ~/awscli-exe-linux-x86_64.zip ];then
  sudo ~/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
else
  wget -P ~/ "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  unzip -d ~/ ~/awscli-exe-linux-x86_64.zip
  sudo ~/aws/install
fi
if [ ! -e ~/.fzf ];then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  cd ~/.fzf && git pull && ./install --all
fi

# --- Desktop specific ---
if [ -n "$DISPLAY" ]; then
  sudo apt update && sudo apt install -y $DESKTOP_APT_PACKAGES
  sudo snap install code --classic
  sudo snap install obsidian --classic
  sudo snap install slack
fi

# --- Final Clean-up ---
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

echo "========================================"
echo "✅ Setup complete! Please reboot your system."
echo "========================================"