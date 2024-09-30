# Tree-sitter
eval %sh{ kak-tree-sitter -dks --init "$kak_session" --with-highlighting --with-text-objects -vvv }
# colorscheme catppuccin_macchiato

define-command -override tree-sitter-user-after-highlighter %{
  add-highlighter -override buffer/show-matching show-matching -previous
}

