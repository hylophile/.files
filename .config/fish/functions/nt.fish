function nt
    while true
        ls -d * | entr -d -c -r $argv
    end
end
