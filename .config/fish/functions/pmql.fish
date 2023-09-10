function pmql --wraps='pacman -Ql' --description 'alias pmql=pacman -Ql'
  pacman -Ql $argv; 
end
