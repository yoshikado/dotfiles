#!/bin/bash

set -eu

# --- Argument Parsing ---
# Set a default flag. We'll install fonts unless told otherwise.
INSTALL_FONTS=true

# Check if the first argument is '--no-fonts'
if [[ "$#" -gt 0 && "$1" == "--no-fonts" ]]; then
  echo "⚠️ --no-fonts flag detected. Skipping Nerd Font installation."
  INSTALL_FONTS=false
fi


# =================================================================================
# Dotfiles Installation Script
# =================================================================================

# Variables
dir=~/dotfiles                    # Dotfiles directory
olddir=~/dotfiles_old/            # Old dotfiles backup directory
# List of files/folders to symlink in home directory
dotfiles=".gitconfig .tmux.conf .zshrc .vimrc"
cfgdirs=".ssh .local/share/juju .aws"

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
for file in $dotfiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file $olddir | true
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file | true
done

# --- Create directories ---
mkdir -p ~/.vim/swap ~/.vim/backup ~/.vim/undo
mkdir -p ~/.local/share
mkdir -p ~/.local/bin

# --- Clone tmux plugin manager ---
if [ ! -e ~/.tmux/plugins/tpm ];then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- Clone vim-plugin ---
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# --- Clone zsh plugin ---
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# --- Create symlinks ---
for cfgdir in $cfgdirs; do
    echo "Moving any existing config dir from ~ to $olddir"
    mv ~/$cfgdir $olddir | true
done
ln -s ~/config/.ssh ~/.ssh
ln -s ~/config/juju ~/.local/share/juju
ln -s ~/config/.aws ~/.aws

# --- Install nerd fonts (Now conditional) ---
# This block will only run if INSTALL_FONTS is true
if [ "$INSTALL_FONTS" = true ]; then
  echo "Installing Nerd Fonts..."
  ./_install-nerd-font.sh JetBrainsMono
  ./_install-nerd-font.sh Meslo
  ./_install-nerd-font.sh Hack
  ./_install-nerd-font.sh SpaceMono
  ./_install-nerd-font.sh UbuntuMono
  ./_install-nerd-font.sh UbuntuSans
  echo "✅ Font installation complete."
else
  # This message is shown if fonts are skipped
  echo "Skipping Nerd Font installation as requested."
fi

# --- Change default shell to zsh ---
echo "Update default shell to zsh."
chsh -s $(which zsh)

echo "✅ Installation complete!"