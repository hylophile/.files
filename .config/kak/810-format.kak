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

install-formatter "python" "ruff format --quiet -"
install-formatter "go" "gofmt"
# install-formatter "html"       "prettier --parser html"
# install-formatter "json"       "prettier --parser json"
# install-formatter "yaml"       "prettier --parser yaml"
# install-formatter "css"        "prettier --parser css"
# install-formatter "typescript" "prettier --parser typescript"
# install-formatter "javascript" "prettier --parser typescript"
# install-formatter "tsx"        "prettier --parser typescript"
# install-formatter "markdown"   "prettier --parser markdown"
# install-formatter "svelte"     "prettier --parser svelte"
install-formatter "html"       "prettierd  dummy.html"
install-formatter "json"       "prettierd  dummy.json"
install-formatter "yaml"       "prettierd  dummy.yaml"
install-formatter "css"        "prettierd  dummy.css"
install-formatter "typescript" "prettierd  dummy.ts"
install-formatter "javascript" "prettierd  dummy.ts"
install-formatter "tsx"        "prettierd  dummy.ts"
install-formatter "markdown"   "prettierd  dummy.md"
install-formatter "svelte"     "prettierd  dummy.svelte"
