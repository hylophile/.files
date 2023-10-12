function fish_prompt
    set -l retc red
    test $status = 0; and set retc brmagenta

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set -l field_name $argv[2]
        set -l field_value $argv[3]

        set_color normal
        set_color $retc
        echo -n ' '
        set_color -o green
        echo -n '('
        set_color normal
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ')'
    end


    set_color normal
    set_color cyan
    echo

    # if test "$CONTAINER_ID" != ""
    #     printf "󰆢 "
    # end

    echo -n (date +%H)
    set_color $retc
    echo -n ⋅
    set_color normal
    set_color cyan
    echo -n (date +%M)
    set_color $retc
    echo -n ⋅
    set_color normal
    set_color cyan
    echo -n (date +%S)
    set_color $retc
    echo -n ' — '

    if functions -q fish_is_root_user; and fish_is_root_user
        set_color red
    else
        set_color cyan
    end

    echo -n $USER
    set_color $retc
    echo -n @
    set_color normal

    # if [ -z "$SSH_CLIENT" ]
    #     set_color cyan
    # else
    #     set_color cyan
    # end
    if test "$CONTAINER_ID" = ""
        set_color cyan
    else
        set_color green
    end

    echo -n (cat /etc/hostname)

    # echo -n " "(pwd)
    # set_color -o $retc
    set_color cyan
    echo -n " "
    if string match -q -- "$HOME*" "$PWD"
        printf "~"
    end
    for i in (dirs | sed 's#/#\n#g' | tail -n +2)
        set_color $retc
        echo -n /
        set_color normal
        set_color cyan
        printf "%s" $i
    end
    set_color -o green
    # echo -n ']'

    # Date
    #_nim_prompt_wrapper $retc '' (date +%X)

    # Vi-mode
    # The default mode prompt would be prefixed, which ruins our alignment.
    function fish_mode_prompt
    end

    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        set -l mode
        switch $fish_bind_mode
            case default
                set mode (set_color --bold red)N
            case insert
                set mode (set_color --bold green)I
            case replace_one
                set mode (set_color --bold green)R
                echo '[R]'
            case replace
                set mode (set_color --bold cyan)R
            case visual
                set mode (set_color --bold magenta)V
        end
        set mode $mode(set_color normal)
        _nim_prompt_wrapper $retc '' $mode
    end


    # Virtual Environment
    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    # and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")
    and _nim_prompt_wrapper $retc V (python --version)

    # git
    set -l prompt_git (fish_git_prompt '%s')
    test -n "$prompt_git"
    and _nim_prompt_wrapper green "" $prompt_git
    # echo (fish_git_prompt)

    # Battery status
    type -q acpi
    and test (acpi -a 2> /dev/null | string match -r off)
    and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)

    # New line
    echo

    # Background jobs
    set_color normal

    for job in (jobs)
        set_color $retc
        echo -n '│ '
        set_color brown
        echo $job
    end

    set_color normal
    set_color $retc
    # echo -n '╰─>'
    set_color -o green

    if test (echo $IN_NIX_SHELL)
        echo -n 'nix:'
    end

    # if test "$CONTAINER_ID" != ""
    #     printf "󰆢 "
    # end
    echo -n 'λ '
    set_color normal
end
