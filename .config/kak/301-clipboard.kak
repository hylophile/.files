define-command extra-yank-buffile -docstring 'yank the path of the current buffer' %{
  set-register p %val{buffile}
}

define-command extra-yank-system -docstring 'yank into the system clipboard' %{
  execute-keys -draft "<a-|>wl-copy --trim-newline<ret>"
}

define-command extra-paste-system -docstring 'paste from the system clipboard' %{
  execute-keys -draft "!wl-paste --no-newline<ret>"
}

define-command extra-replace-system -docstring 'replace selections with the system clipboard' %{
  set-register \"  %sh{ wl-paste --no-newline }
  execute-keys '""R'
}

map global user p ':extra-paste-system<ret>' -docstring 'paste selections from system clipboard'
map global user y ':extra-yank-system<ret>'  -docstring 'yank to system clipboard'
map global user R ':extra-replace-system<ret>'  -docstring 'replace selections from system clipboard'

