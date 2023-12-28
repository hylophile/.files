if command -v zoxide >/dev/null
    zoxide init fish --cmd d | source
end

if command -v direnv >/dev/null
    direnv hook fish | source
end

function set_wezterm_user_vars --on-event fish_preexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG (echo -n $argv | base64 --wrap 0)
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_CWD (echo -n (pwd) | base64 --wrap 0)
end

function unset_wezterm_prog --on-event fish_postexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG ""
end

set -U XDG_CURRENT_DESKTOP sway
set -U MOZ_ENABLE_WAYLAND 1
set -U QT_QPA_PLATFORMTHEME qt5ct
set -U _JAVA_AWT_WM_NONREPARENTING 1


fish_add_path ~/.nix-profile/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.config/emacs/bin
