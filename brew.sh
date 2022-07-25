#!/usr/bin/env bash

# Install homebrew. Check the latest script here https://brew.sh/
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install homebrew apps
brew install awscli
brew install bash
brew install bazaar
brew install black
brew install byobu
brew install charm
brew install charmcraft
brew install coreutils
brew install findutils
brew install flake8
brew install fping
brew install git
brew install git-lfs
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
brew install tmux
brew install tox
brew install tree
brew install vim
brew install watch
brew install wget
brew install xz

# Cask
brew install alfred
brew install iterm2
brew install maccy
brew install meld
brew install multipass
brew install mattermost
brew install mos
brew install zenmap

# Remove outdated versions from the cellar.
brew cleanup