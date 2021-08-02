function pms --wraps='sudo pacman -Ss' --description 'alias pms=sudo pacman -Ss'
  sudo pacman -Ss $argv; 
end
