# Add brew binaries in fish path
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths

# Oh-my-fish can be easily replaced with manual steps. so far not so useful
# Install oh-my-fish
# curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# omf
# omf install peco
# omf install brew

# Install fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# fisher plugins
fisher install PatrickF1/fzf.fish
fisher install jethrokuan/z
fisher install simnalamburt/shellder
fisher install IlanCosman/tide@v5
