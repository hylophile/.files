function pmu --wraps='sudo pacman -Syu' --description 'alias pmu=sudo pacman -Syu'
  sudo pacman -Syu $argv; 
end
