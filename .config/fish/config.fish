set fish_greeting ""

# PATH
set -gx PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/grep/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/gnu-tar/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/gnu-time/libexec/gnubin $PATH

# aliases
if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "exa -l -a -g --icons"
end
alias myip "curl http://ipecho.net/plain"
alias gga "git branch -a | tr -d \* | sed '/->/d' | xargs git grep"