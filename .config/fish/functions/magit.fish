function magit --wraps="emacsclient"
    if ! pgrep --full "emacs --daemon=magit" >/dev/null
        emacs --daemon=magit
    end
    emacsclient --tty --socket=magit --eval "(progn (magit-status) (delete-other-windows))" $argv
end
