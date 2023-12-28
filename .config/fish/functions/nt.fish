function nt
    while true
        ls -d * | entr -d -cc -r $argv
    end
end
