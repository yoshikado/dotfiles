#!/bin/bash

# =================================================================================
# Dotfiles Installation Script
# =================================================================================

# Variables
dir=~/dotfiles                    # Dotfiles directory
olddir=~/dotfiles_old             # Old dotfiles backup directory
# List of files/folders to symlink in home directory
files=".gitconfig .tmux.conf .zshrc"

# --- Main Logic ---

# Create dotfiles_old in homedir
echo "Creating backup directory for existing dotfiles at $olddir"
mkdir -p $olddir
echo "...done"

# Change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# Move any existing dotfiles in homedir to dotfiles_old directory,
# then create symlinks from the homedir to any files in the
# dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

# --- Create symlinks ---
mkdir -p ~/.local/share
mkdir -p ~/.local/bin
rm -r ~/.ssh
ln -s ~/config/.ssh ~/.ssh
ln -s ~/config/juju ~/.local/share/juju
ln -s ~/config/.aws ~/.aws

# --- Install nerd fonts ---
./install-nerd-font.sh JetBrainsMono
./install-nerd-font.sh Meslo
./install-nerd-font.sh Hack
./install-nerd-font.sh SpaceMono
./install-nerd-font.sh UbuntuMono
./install-nerd-font.sh UbuntuSans

echo "✅ Installation complete!"