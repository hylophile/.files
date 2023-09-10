function rsy --wraps='rsync -av --info=progress2' --description 'alias rsy=rsync -av --info=progress2'
  rsync -av --info=progress2 $argv
        
end
