function ent
    set x (string join " " $argv)

    ls | entr -c -s (printf "\"%s\"" $x)
end
