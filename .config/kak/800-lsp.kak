eval %sh{ kak-lsp --kakoune -s $kak_session }
lsp-enable

## common options
lsp-auto-signature-help-enable
lsp-inlay-hints-enable global
lsp-inlay-diagnostics-enable global
lsp-inlay-code-lenses-enable global
lsp-inline-diagnostics-disable global
lsp-diagnostic-lines-disable global
set-option global lsp_hover_anchor true
set-option global lsp_auto_show_code_actions true

# TODO this is ugly as hell; I want to get rid of it
# hook global WinSetOption filetype=(haskell|rust|python|go|javascript|typescript|zig) %{
#   hook window BufWritePre .* lsp-formatting-sync
# }

# Progress report
declare-option -hidden str lsp_modeline_progress ""
define-command -hidden -params 6 -override lsp-handle-progress %{
    set-option global lsp_modeline_progress %sh{
        if ! "$6"; then
            echo "$2${5:+" ($5%)"}${4:+": $4"}"
        fi
    }
}

