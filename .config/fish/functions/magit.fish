function magit --wraps='emacs --no-window-system --eval "(progn (magit-status) (delete-other-windows))"' --description 'alias magit=emacs --no-window-system --eval "(progn (magit-status) (delete-other-windows))"'
  emacs --no-window-system --eval "(progn (magit-status) (delete-other-windows))" $argv
        
end
