#bind -k f3 'printf ""'

set -x MOZ_ENABLE_WAYLAND 1

set -x FZF_ALT_C_COMMAND 'fd --type directory --hidden .'
set -x FZF_CTRL_T_COMMAND 'fd --hidden .'

# Bun
set -Ux BUN_INSTALL "/home/$USER/.bun"
set -px --path PATH "/home/$USER/.bun/bin"

fish_add_path -p ~/.emacs.d/bin ~/.config/fisactl/bin

set -U nvm_default_version v16.17.1

set -U EDITOR nvim

zoxide init fish --cmd d | source
