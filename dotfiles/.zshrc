# ~/.zshrc

# --- Environment Variables ---
# Set the default editor for command-line tools (like git)
export EDITOR='nvim'
export VISUAL='nvim'

# --- Aliases ---
# Easier navigation
alias ..="cd .."
alias ...="cd ../.."

# Git shortcuts
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# System shortcuts
alias update='sudo apt update && sudo apt upgrade -y'
alias ls='ls --color=auto' # Enable color
alias ll='ls -alF'         # List all files in detail
alias la='ls -A'           # List all files including hidden

# --- Functions ---
# Create a directory and cd into it immediately
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# --- Prompt Customization ---
# For a modern, powerful prompt, many people use tools like Starship or Powerlevel10k.
# To use Starship, you'd add this to the end of your .zshrc:
eval "$(starship init zsh)"

# --- Sourcing Other Files ---
# For better organization, you can split your config into multiple files
# and load them here.
# source $HOME/.config/zsh/aliases.sh
# source $HOME/.config/zsh/functions.sh