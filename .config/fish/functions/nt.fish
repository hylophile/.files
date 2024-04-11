function nt
    while sleep 0.1
        fd | entr -d -cc -r $argv
    end
end
