#!/usr/bin/env sh

killall polybar

for m in $(polybar --list-monitors | cut -d":" -f1); do
    sleep 0.5
    MONITOR=$m polybar --reload top 2>/tmp/polybar_"$m" &
done
