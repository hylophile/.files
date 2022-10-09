#!/usr/bin/env sh

touch "$HOME/azk/log/$(date "+%Y-%m-%d").csv"

state=$(cat "$HOME/azk/log/$(date "+%Y-%m-%d").csv" | tail -n 1 | cut -d, -f1)

if [ "$state" = "strt" ]; then
    echo "%{T4}🌈"
elif [ "$state" = "stop" ]; then
    echo "%{B#ff79c6}%{F#ff79c6}WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
    # echo "%{O200}break"
else
    echo "%{B#ff79c6}%{F#ff79c6}WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
    # echo "break"
fi
