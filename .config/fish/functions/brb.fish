function brb --wraps='systemctl suspend' --description 'alias brb=systemctl suspend'
  systemctl suspend $argv; 
end
