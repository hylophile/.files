function fish_prompt
    set -l retc red
    set -l mainc cyan
    test $status = 0; and set retc brmagenta

    if test $COLUMNS -ne 80
        # set promptbg e1eaed
        set promptbg 282a36
        # set promptbg f1ece4
        # set promptbg e4ddd2
        # set promptbg f2e9e1
        # set promptbg dcd3c6
        # set promptbg e4ddd2
        # set promptbg f1ece4
        # set promptbg f7f3ee
    end

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set -l field_name $argv[2]
        set -l field_value $argv[3]

        set_color normal -b $promptbg
        set_color $retc
        echo -n ' '
        set_color -o green
        echo -n '('
        set_color normal -b $promptbg
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ')'
    end

    set_color normal -b $promptbg
    set_color $mainc

    # if test "$CONTAINER_ID" != ""
    #     printf "󰆢 "
    # end

    echo -n (date +%H)
    set_color -o $retc
    echo -n : #⋅
    set_color normal -b $promptbg
    set_color $mainc
    echo -n (date +%M)
    set_color -o $retc
    echo -n : #⋅
    set_color normal -b $promptbg
    set_color $mainc
    echo -n (date +%S)
    set_color -o $retc
    echo -n " ⊢ "

    set_color normal -b $promptbg
    if functions -q fish_is_root_user; and fish_is_root_user
        set_color red
    else
        set_color $mainc
    end

    echo -n $USER
    set_color -o $retc
    echo -n @
    set_color normal -b $promptbg

    # if [ -z "$SSH_CLIENT" ]
    #     set_color $mainc
    # else
    #     set_color $mainc
    # end
    if test "$CONTAINER_ID" = ""
        set_color $mainc
    else
        set_color --underline $mainc
    end

    echo -n (cat /etc/hostname)
    if test "$CONTAINER_ID" != ""
        echo -n ."$CONTAINER_ID"
    end

    set_color normal -b $promptbg

    echo -n " "
    set_color -o $retc
    echo -n ⊣
    set_color normal -b $promptbg

    # echo -n " "(pwd)
    # set_color -o $retc
    set_color $mainc
    echo -n " "
    if string match -q -- "$HOME*" "$PWD"
        printf "~"
    end
    for i in (dirs | sed 's#/#\n#g' | tail -n +2)
        set_color -o $retc
        echo -n /
        set_color normal -b $promptbg
        set_color $mainc
        printf "%s" $i
    end
    set_color -o green
    # echo -n ']'

    # Date
    #_nim_prompt_wrapper $retc '' (date +%X)

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
    # type -q acpi
    # and test (acpi -a 2> /dev/null | string match -r off)
    # and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)
    #
    # New line
    # echo
    printf '\x1b[J\n'
    set_color normal
    printf '\x1b[J'

    # Background jobs
    set_color normal -b $promptbg

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
