define-command buffer-to-html-pandoc -docstring 'convert buffer content to html with pandoc and copy to clipboard' %{
  exec -draft '%!pandoc<ret><a-|>wl-copy<ret>d'
}
