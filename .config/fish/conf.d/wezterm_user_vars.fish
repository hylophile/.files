function set_wezterm_user_vars --on-event fish_preexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG (echo -n $argv | base64 -w 0)
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_CWD (echo -n (pwd) | base64 -w 0)
end

function unset_wezterm_prog --on-event fish_postexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG ""
end
