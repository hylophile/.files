define-command surround-key -docstring 'surround key' %{
  on-key %{
    add-surrounding-pair %val{key} %val{key}
  }
}

define-command surround-tag -docstring 'surround tag' %{
  prompt surround-tag: %{
    add-surrounding-pair "<%val{text}>" "</%val{text}>"
  }
}
    
define-command -override add-surrounding-pair -params 2 -docstring 'add surrounding pairs left and right to selection' %{
  evaluate-commands -no-hooks -save-regs '"' %{
    set-register '"' %arg{1}
    execute-keys -draft P
    set-register '"' %arg{2}
    execute-keys -draft p
  }
}

define-command surround-replace -docstring 'prompt for a surrounding pair and replace it with another' %{
  on-key %{
    surround-replace-sub %val{key}
  }
}

define-command -hidden surround-replace-sub -params 1 %{
	on-key %{
    evaluate-commands -no-hooks -draft %{
      execute-keys "<a-a>%arg{1}"

      # select the surrounding pair and add the new one around it
      enter-user-mode surround-add
      execute-keys %val{key}
    }

    # delete the old one
    match-delete-surround-key %arg{1}
	}
}

# surround-add mode; support most of the useful delimiters
declare-user-mode surround-add
map global surround-add "'" ":add-surrounding-pair ""'"" ""'""<ret>" -docstring 'surround selections with quotes'
map global surround-add ' ' ':add-surrounding-pair " " " "<ret>'     -docstring 'surround selections with pipes'
map global surround-add '"' ':add-surrounding-pair ''"'' ''"''<ret>' -docstring 'surround selections with double quotes'
map global surround-add '(' ':add-surrounding-pair ( )<ret>'         -docstring 'surround selections with curved brackets'
map global surround-add ')' ':add-surrounding-pair ( )<ret>'         -docstring 'surround selections with curved brackets'
map global surround-add '*' ':add-surrounding-pair * *<ret>'         -docstring 'surround selections with stars'
map global surround-add '<' ':add-surrounding-pair <lt> <gt><ret>'   -docstring 'surround selections with chevrons'
map global surround-add '>' ':add-surrounding-pair <lt> <gt><ret>'   -docstring 'surround selections with chevrons'
map global surround-add '[' ':add-surrounding-pair [ ]<ret>'         -docstring 'surround selections with square brackets'
map global surround-add ']' ':add-surrounding-pair [ ]<ret>'         -docstring 'surround selections with square brackets'
map global surround-add '_' ':add-surrounding-pair "_" "_"<ret>'     -docstring 'surround selections with underscores'
map global surround-add '{' ':add-surrounding-pair { }<ret>'         -docstring 'surround selections with angle brackets'
map global surround-add '|' ':add-surrounding-pair | |<ret>'         -docstring 'surround selections with pipes'
map global surround-add '}' ':add-surrounding-pair { }<ret>'         -docstring 'surround selections with angle brackets'
map global surround-add '«' ':add-surrounding-pair « »<ret>'         -docstring 'surround selections with French chevrons'
map global surround-add '»' ':add-surrounding-pair « »<ret>'         -docstring 'surround selections with French chevrons'
map global surround-add '“' ':add-surrounding-pair “ ”<ret>'         -docstring 'surround selections with French chevrons'
map global surround-add '”' ':add-surrounding-pair “ ”<ret>'         -docstring 'surround selections with French chevrons'
map global surround-add ` ':add-surrounding-pair ` `<ret>'           -docstring 'surround selections with ticks'
map global surround-add t ':surround-tag<ret>'                       -docstring 'surround selections with a <tag>'

## match mode
define-command -hidden match-delete-surround -docstring 'delete surrounding key' %{
  on-key %{
    match-delete-surround-key %val{key}
  }
}

define-command -hidden match-delete-surround-key -params 1 %{
  execute-keys -draft "<a-a>%arg{1}i<del><esc>a<backspace><esc>"
}

declare-user-mode match
map global match a '<a-a>'                               -docstring 'match around'
map global match d ':match-delete-surround<ret>'         -docstring 'delete surround'
map global match i '<a-i>'                               -docstring 'match inside'
map global match m m                                     -docstring 'select other matching delimiter'
map global match s ':enter-user-mode surround-add<ret>'  -docstring 'add surrounding pairs'
map global match r ':surround-replace<ret>'              -docstring 'replace surrounding pairs'

declare-user-mode match-extend
map global match-extend a '<A-a>'                        -docstring 'extend around'
map global match-extend i '<A-i>'                        -docstring 'extend inside'
map global match-extend m M                              -docstring 'extend other matching delimiter'


