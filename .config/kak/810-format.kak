define-command install-formatter -params 2 %{
  eval %sh{
    cat << EOF
hook global BufSetOption filetype=$1 %{
    set-option buffer formatcmd "$2"
    hook buffer -group auto-format-$1 BufWritePre .* format
    hook buffer BufSetOption filetype=.* %{
        remove-hooks buffer auto-format-$1
    }
}
EOF
  }
}

install-formatter "svelte" "npx prettier --parser svelte"
