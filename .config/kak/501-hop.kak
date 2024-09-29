evaluate-commands %sh{ hop-kak --init }

declare-option str hop_kak_keyset "tnseriaodhcdhcxzplfuwyq"

define-command hop-kak %{
  eval -no-hooks -- %sh{ hop-kak --keyset "$kak_opt_hop_kak_keyset" --sels "$kak_selections_desc" }
}

define-command hop-kak-words %{
  evaluate-commands -draft %{
    execute-keys 'gtGbxs\w+<ret>'
    evaluate-commands -no-hooks -client "%val{client}" -- %sh{ hop-kak --keyset "$kak_opt_hop_kak_keyset" --sels "$kak_selections_desc" }
  }
}

map global normal J :hop-kak<ret>
map global normal j :hop-kak-words<ret>

