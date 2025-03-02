function ,series
    function find_highest_episode -a query
        set max_season 0
        set max_episode 0
        set max_file ""
        set -l list (xsv input -d '\t' ~/.config/mpv/hey.log | xsv select datetime,filename | rgi $query)
        set -l regex 's([0-9]{2})e([0-9]{2})'

        for file in $list

            if string match -riq $regex $file
                set match (string match -ri $regex $file)
                set season $match[2]
                set episode $match[3]

                if test $season -gt $max_season
                    set max_season $season
                    set max_episode $episode
                    set max_file $file
                else if test $season -eq $max_season -a $episode -gt $max_episode
                    set max_episode $episode
                    set max_file $file
                end
            end
        end

        set_color cyan
        printf "%20s: " "$query"
        set_color magenta
        printf "S%s E%s" $max_season $max_episode
        set_color normal
        set date (echo $max_file | rg -o '^[0-9]{4}-[0-9]{2}-[0-9]{2}')
        printf " ($date)\n"
    end

    for arg in $argv
        find_highest_episode $arg
    end
end
