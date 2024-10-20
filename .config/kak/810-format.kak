define-command install-formatter -params 2 %{
  eval %sh{
    printf %s "hook global BufSetOption filetype=$1 %{
                set-option buffer formatcmd '$2'
                hook buffer -group auto-format-$1 BufWritePre .* format
                # breaks e.g. svelte, i guess because the filetype gets set twice
                # hook buffer BufSetOption filetype=.* %{
                #     remove-hooks buffer auto-format-$1
                # }
            }"
  }
}

install-formatter "svelte" "prettier --parser svelte"
install-formatter "typescript" "prettier --parser typescript"

