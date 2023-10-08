#bind -k f3 'printf ""'

# set -x MOZ_ENABLE_WAYLAND 1

# set -x FZF_ALT_C_COMMAND 'fd --type directory --hidden .'
# set -x FZF_CTRL_T_COMMAND 'fd --hidden .'

fish_add_path -p ~/.config/emacs/bin
# fish_add_path -p ~/.config/fisactl/bin

# set -U NIX_PATH ~/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels

# set -U nvm_default_version v16.19.1

# set -gx EDITOR nvim
# set -gx VISUAL nvim

#source ~/.config/fish/hm-session-vars.fish

# bind \cH backward-kill-word
# bind \cw backward-kill-bigword

function set_wezterm_user_vars --on-event fish_preexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG (echo -n $argv | base64 --wrap 0)
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_CWD (echo -n (pwd) | base64 --wrap 0)
end

function unset_wezterm_prog --on-event fish_postexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG ""
end

zoxide init fish --cmd d | source
direnv hook fish | source
