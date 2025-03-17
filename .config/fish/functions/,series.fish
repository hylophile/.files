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

        function days_ago
            set -l date1 (date -d (date --iso-8601=d) +%s)
            set -l date2 (date -d $argv[1] +%s)
            set -l diff (math "round (($date1 - $date2) / 86400)")
            echo $diff
        end

        set_color cyan
        printf "%20s:  " "$query"
        set_color magenta
        printf "S%s E%s" $max_season $max_episode
        set_color normal
        set date (echo $max_file | rg -o '^[0-9]{4}-[0-9]{2}-[0-9]{2}')
        printf " %4s days ago  " "$(days_ago $date)"
        set_color ffb86c
        printf "%s\n" "$(string split , $max_file | tail -n1)"
    end

    for arg in $argv
        find_highest_episode $arg
    end
end
