#!/usr/bin/env sh

filename="$HOME/azk/log/$(date "+%Y-%m-%d").csv"
touch $filename

output() {
    state=$(cat $filename | tail -n 1 | cut -d, -f1)

    if [ "$state" = "strt" ]; then
        echo '{"state": "work"}'
    elif [ "$state" = "stop" ]; then
        echo '{"state": "break"}'
    else
        echo '{"state": "break"}'
    fi
}

output

inotifywait -m -e modify -q $filename | 
   while read file_path file_event file_name; do 
       output
   done


