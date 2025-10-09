# ~/.zshrc

# --- Environment Variables ---
# Set the default editor for command-line tools (like git)
export EDITOR='vim'
export VISUAL='vim'
export PATH=$PATH:/$HOME/go/bin
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# --- History ---
# Set the history file
HISTFILE=~/.zsh_history
# Set the number of history entries to save and load
HISTSIZE=1000000
SAVEHIST=1000000
# Enable history sharing between all Zsh sessions
setopt SHARE_HISTORY
# Prevent duplicate entries from being written to the history file
setopt HIST_SAVE_NO_DUPS
# Prevent commands with a leading space from being written to the history file
setopt HIST_IGNORE_SPACE
# Prevent duplicate commands from being shown during history searches
setopt HIST_FIND_NO_DUPS

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
alias gdiff='git diff --no-index'

# System shortcuts
alias update='sudo apt update && sudo apt upgrade -y'
alias ls='ls --color=auto' # Enable color
alias ll='ls -alF'         # List all files in detail
alias la='ls -A'           # List all files including hidden
alias canonicalvpn="sudo openvpn /home/yoshi/config/keys/vpn/canonical/us-yoshikadokawa.conf"
alias canonicalukvpn="sudo openvpn /home/yoshi/config/keys/vpn/canonical/uk-yoshikadokawa@2.conf"

# --- Functions ---
# Create a directory and cd into it immediately
mkcd() {
  mkdir -p "$1" && cd "$1"
}

function command_not_found_handler() {
  # check because c-n-f could've been removed in the meantime
  if [ -x /usr/lib/command-not-found ]; then
    /usr/lib/command-not-found -- "$1"
    return $?
  elif [ -x /usr/share/command-not-found/command-not-found ]; then
    /usr/share/command-not-found/command-not-found -- "$1"
    return $?
  else
    printf "%s: command not found\n" "$1" >&2
    return 127
  fi
}

function _fzf_cd_ghq() {
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
  local root="$(ghq root)"
  local repo="$(ghq list | fzf --preview="ls -AF --color=always ${root}/{1}")"
  local dir="${root}/${repo}"
  [ -n "${dir}" ] && cd "${dir}"
  zle accept-line
  zle reset-prompt
}
zle -N _fzf_cd_ghq
bindkey "^g" _fzf_cd_ghq

# --- Enable plugins ---
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# --- Prompt Customization ---
# For a modern, powerful prompt, many people use tools like Starship or Powerlevel10k.
# To use Starship, you'd add this to the end of your .zshrc:
eval "$(starship init zsh)"

# --- Sourcing Other Files ---
# For better organization, you can split your config into multiple files
# and load them here.
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
