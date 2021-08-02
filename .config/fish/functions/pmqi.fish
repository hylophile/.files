function pmqi --wraps='sudo pacman -Qi' --description 'alias pmqi=sudo pacman -Qi'
  sudo pacman -Qi $argv; 
end
