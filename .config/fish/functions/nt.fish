function nt
    while sleep 0.5
        fd | entr -d -cc -r $argv
    end
end
