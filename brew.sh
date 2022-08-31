#!/usr/bin/env bash

# Install homebrew. Check the latest script here https://brew.sh/
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install homebrew apps
brew install awscli
brew install bash
brew install bat
brew install bazaar
brew install black
brew install byobu
brew install charm
brew install charmcraft
brew install coreutils
brew install exa
brew install fd
brew install findutils
brew install fish
brew install flake8
brew install fping
brew install fzf
brew install ghq
brew install git
brew install grep
brew install gmp
brew install gnu-sed
brew install gnu-tar
brew install gnu-time
brew install gnupg
brew install htop
brew install hugo
brew install iftop
brew install ipcalc
brew install iproute2mac
brew install jq
brew install juju
brew install juju-wait
brew install kubernetes-cli
brew install mtr
brew install ncdu
brew install ncurses
brew install neovim
brew install nmap
brew install oath-toolkit
brew install openssh
brew install openvpn
brew install p7zip
brew install shellcheck
brew install six
brew install snap
brew install snapcraft
brew install sshuttle
brew install svn
brew install tmux
brew install tox
brew install tree
brew install vim
brew install watch
brew install wget
brew install xz

# Cask
brew install alfred
brew install cmd-eikana
brew install dropbox
brew install google-chrome
brew install iterm2
brew install karabiner-elements
brew install maccy
brew install meld
brew install multipass
brew install mattermost
brew install mos
brew install numi
brew install obs
brew install obsidian
brew install rectangle
brew install slack
brew install spotify
brew install syncthing --cask
brew install tailscale --cask
brew install telegram
brew install visual-studio-code
brew install vb-cable
brew install vlc
brew install zenmap
brew install zoom

# Fonts
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
brew install font-source-code-pro
brew install font-fira-code

# Remove outdated versions from the cellar.
brew cleanup

# Switch to fish shell
if ! grep -F -q "${BREW_PREFIX}/bin/fish" /etc/shells; then
  echo "${BREW_PREFIX}/bin/fish" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/fish";
fi;
