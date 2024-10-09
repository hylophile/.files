function pmi --wraps='sudo pacman -S' --description 'alias pmi sudo pacman -S'
  sudo pacman -S $argv
        
end
