function nt
    while sleep 0.25
        fd | entr -d -cc -r $argv
    end
end
