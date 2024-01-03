function distrobox_auto_setup
    if command -q distrobox-host-exec
        function distrobox_auto_switch --on-event fish_prompt
            if test -f /run/.containerenv # in container
                set --local current_container (grep ^name= /run/.containerenv | cut -d\" -f2)
                if test "$DBX_NAME" = $current_container
                    # in correct container
                    return
                end

                set -U DISTROBOX_PRE_EXIT_PWD (pwd)
                set_color cyan
                printf "exit container: "
                set_color magenta
                printf "%s\n" $current_container
                exit
            else
                if set --query DBX_NAME
                    if distrobox list | cut -d' ' -f3 | grep $DBX_NAME >/dev/null
                        set_color cyan
                        printf "enter container: "
                        set_color magenta
                        printf "%s\n" $DBX_NAME
                        distrobox enter $DBX_NAME -- fish -C direnv_reload
                        # this runs after exiting the distrobox
                        if set --query DISTROBOX_PRE_EXIT_PWD
                            cd $DISTROBOX_PRE_EXIT_PWD
                            set -U --erase DISTROBOX_PRE_EXIT_PWD
                        end
                        distrobox_auto_switch
                    else
                        set_color red
                        printf "Tried to enter container '%s', but it doesn't exist.\n" $DBX_NAME
                    end
                end
            end
        end
    end

    function direnv_reload
        if command -q direnv
            direnv reload
        else
            set_color red
            printf "direnv not installed; not reloading\n"
        end
    end
end
