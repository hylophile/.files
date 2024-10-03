define-command wezterm-split -params 1 -docstring 'split' %{
  nop %sh{
    wezterm cli split-pane --pane-id "$kak_client_env_WEZTERM_PANE" "--$1" -- kak -c $kak_session
  }
}

define-command wezterm-toggle-zoom -docstring 'toggle pane zoom' %{
  nop %sh{
    wezterm cli zoom-pane --toggle --pane-id "$kak_client_env_WEZTERM_PANE"
  }
}

define-command wezterm-select-pane -params 1 -docstring 'select pane' %{
  nop %sh{
    wezterm cli activate-pane-direction $1
  }
}

define-command wezterm-set-user-var -params 2 -docstring 'run lua by changing wezterm user var' %{
  nop %sh{
    printf "\033]1337;SetUserVar=%s=%s\007" "$1" $(echo -n "$2" | base64 --wrap=0) > /dev/tty
  }
}

declare-user-mode window-wezterm
map global window-wezterm a       ':wezterm-set-user-var pane-select-mode 0<ret>' -docstring 'pane-select-mode'
map global user           a       ':wezterm-set-user-var pane-select-mode 0<ret>' -docstring 'pane-select-mode'
map global window-wezterm Q       ':q!<ret>'                                      -docstring 'close window (force)'
map global window-wezterm q       ':q<ret>'                                       -docstring 'close window'
map global window-wezterm d       ':q<ret>'                                       -docstring 'close window'
map global window-wezterm k       ':q<ret>'                                       -docstring 'close window'
map global window-wezterm <left>  ':wezterm-select-pane left<ret>'                -docstring 'move left'
map global window-wezterm <down>  ':wezterm-select-pane down<ret>'                -docstring 'move down'
map global window-wezterm <up>    ':wezterm-select-pane up<ret>'                  -docstring 'move up'
map global window-wezterm <right> ':wezterm-select-pane right<ret>'               -docstring 'move right'
map global window-wezterm n       ':wezterm-select-pane next<ret>'                -docstring 'move to next'
map global window-wezterm w       ':wezterm-select-pane next<ret>'                -docstring 'move to next'
map global window-wezterm p       ':wezterm-select-pane prev<ret>'                -docstring 'move to prev'
map global window-wezterm W       ':wezterm-select-pane prev<ret>'                -docstring 'move to prev'
map global window-wezterm h       ':wezterm-split bottom<ret>'                    -docstring 'horizontal split'
map global window-wezterm v       ':wezterm-split right<ret>'                     -docstring 'vertical split'
map global window-wezterm z       ':wezterm-toggle-zoom<ret>'                     -docstring 'toggle pane zoom'
map global window-wezterm o       ':wezterm-toggle-zoom<ret>'                     -docstring 'toggle pane zoom'

