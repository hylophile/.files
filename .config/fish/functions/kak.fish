function kak --wraps='wezterm start --cwd (pwd) kak 2>/dev/null' --description 'alias kak=wezterm start --cwd (pwd) kak 2>/dev/null'
  wezterm start --cwd (pwd) kak 2>/dev/null $argv
        
end
