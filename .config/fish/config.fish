if command -q zoxide
    zoxide init fish --cmd d | source
end

if command -q direnv
    direnv hook fish | source
end

function set_wezterm_user_vars --on-event fish_preexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG (echo -n $argv | base64 --wrap 0)
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_CWD (echo -n (pwd) | base64 --wrap 0)
end

function unset_wezterm_prog --on-event fish_postexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG ""
end

if command -q distrobox; and command -q direnv
    function distrobox-enter-auto --on-event fish_prompt
        if test -f /run/.containerenv # in container
            set --local current_container (rg ^name= /run/.containerenv | cut -d\" -f2)
            if test "$DISTROBOX_ENTER_NAME" = $current_container
                # in correct container
                return
            end

            set -U DISTROBOX_PRE_EXIT_PWD (pwd)
            set_color magenta
            printf "(exiting %s)\n" $current_container
            exit
        else
            if set --query DISTROBOX_ENTER_NAME
                if distrobox list | cut -d' ' -f3 | rg $DISTROBOX_ENTER_NAME >/dev/null
                    set_color magenta
                    printf "(entering %s)\n" $DISTROBOX_ENTER_NAME
                    distrobox enter $DISTROBOX_ENTER_NAME -- fish -C 'direnv reload'
                    # this runs after exiting the distrobox
                    if set --query DISTROBOX_PRE_EXIT_PWD
                        cd $DISTROBOX_PRE_EXIT_PWD
                        set -U --erase DISTROBOX_PRE_EXIT_PWD
                    end
                    distrobox-enter-auto
                else
                    printf "Tried entering container %s, but it doesn't exist.\n" $DISTROBOX_ENTER_NAME
                    set status 1
                end
            end
        end
    end
end

set -U XDG_CURRENT_DESKTOP sway
set -U MOZ_ENABLE_WAYLAND 1
set -U QT_QPA_PLATFORMTHEME qt5ct
set -U _JAVA_AWT_WM_NONREPARENTING 1


fish_add_path ~/.nix-profile/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.config/emacs/bin
