function ent
    set x (string join " " $argv)

    fd | entr -cc -s (printf "\"%s\"" $x)
end
