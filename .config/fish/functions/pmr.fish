function pmr --wraps='sudo pacman -Rd' --description 'alias pmr sudo pacman -Rd'
  sudo pacman -Rd $argv
        
end
