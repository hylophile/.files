declare-option -hidden completions pandroam_completion

hook global WinSetOption filetype=markdown %{
  evaluate-commands %sh{
   if echo "$kak_buffile" | grep -q /notes/
   then
   		echo "pandroam-enable-completion"
   fi
  }
  hook buffer WinSetOption filetype=.* %{
    pandroam-disable-completion
  }
}


define-command pandroam-enable-completion %{
  set-option window completers option=pandroam_completion %opt{completers}
  hook window -group pandroam-completion InsertIdle .* %{
    try %{
        # Test whether the previous word is "eat". If it isn't, this
        # command will throw an exception and execution will jump to
        # the "catch" block below.
        execute-keys -draft 2B s\[<ret>
        

        evaluate-commands -draft %{
            # Try to select the entire word before the cursor,
            # putting the cursor at the left-end of the selection.
            # execute-keys h <a-i>w <a-semicolon> H
            exec h<a-t>[H
            # execute-keys x <a-semicolon>

            # The selection's cursor is at the anchor point
            # for completions, and the selection covers
            # the text the completions should replace,
            # exactly the information we need for the header item.
            set-option window pandroam_completion \
                "%val{cursor_line}.%val{cursor_column}+%val{selection_length}@%val{timestamp}"
        }
				eval %sh{
          lines=`rg --no-heading --no-line-number "^#{1,} " < /dev/null`
          hashes=`printf "$lines" | sed -E "s/[^:]+://" | pandoc | sed -E -e 's/.*id="(.*)".*/\1/' -e 's/\-[0-9]$//'`
          paste <(printf "$lines") <(printf "$hashes") | while IFS=$'\t' read -r line hash; do
            link=`printf "$line" | sed -E "s/^([^:]+):#+ +(.+)/[\2](\1/"`
            completion="$link#$hash)"
          	printf 'set-option -add window pandroam_completion "%s||%s"\n' "$completion" "$completion"
          done
				}
    } catch %{
        set-option window pandroam_completion
    }
  }
}

define-command pandroam-disable-completion %{
  set-option window pandroam_completion
  remove-hooks window pandroam-completion
}
