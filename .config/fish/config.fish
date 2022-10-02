#bind -k f3 'printf ""'

set -x MOZ_ENABLE_WAYLAND 1

set -x FZF_ALT_C_COMMAND 'fd --type directory --hidden .'
set -x FZF_CTRL_T_COMMAND 'fd --hidden .'

# Bun
set -Ux BUN_INSTALL "/home/$USER/.bun"
set -px --path PATH "/home/$USER/.bun/bin"

zoxide init fish --cmd d | source
