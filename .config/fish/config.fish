#bind -k f3 'printf ""'

set -x MOZ_ENABLE_WAYLAND 1

set -x FZF_ALT_C_COMMAND 'fd --type directory --hidden .'
set -x FZF_CTRL_T_COMMAND 'fd --hidden .'

# Bun
set -Ux BUN_INSTALL "/home/$USER/.bun"
set -px --path PATH "/home/$USER/.bun/bin"

fish_add_path -p ~/.nix-profile/bin ~/.config/emacs/bin ~/.config/fisactl/bin ~/.local/bin

set -U NIX_PATH ~/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels

set -U nvm_default_version v16.17.1

set -U EDITOR nvim
set -U VISUAL nvim

source ~/.config/fish/hm-session-vars.fish

bind \cH backward-kill-word
bind \cw backward-kill-bigword

zoxide init fish --cmd d | source
direnv hook fish | source
