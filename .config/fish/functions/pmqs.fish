function pmqs --wraps='sudo pacman -Qs' --description 'alias pmqs=sudo pacman -Qs'
  sudo pacman -Qs $argv; 
end
