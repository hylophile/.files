if command -q zoxide
    zoxide init fish --cmd d | source
end

if command -q direnv
    direnv hook fish | source
end

distrobox_auto_setup

set -U XDG_CURRENT_DESKTOP sway
set -U MOZ_ENABLE_WAYLAND 1
set -U QT_QPA_PLATFORMTHEME qt5ct
set -U _JAVA_AWT_WM_NONREPARENTING 1


fish_add_path ~/.nix-profile/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.config/emacs/bin


function ls --wraps=lsd --description 'alias ls=lsd'
    lsd $argv
end

function ll --wraps='lsd -al' --description 'alias ll=lsd -al'
    lsd -al $argv
end

function llt --wraps='lsd -alrt' --description 'alias llt=lsd -alrt'
    lsd -alrt $argv
end
