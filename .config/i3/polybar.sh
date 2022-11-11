#!/usr/bin/env sh

killall polybar

for m in $(xrandr |rg "\sconnected" | cut -d' ' -f 1); do
    sleep 0.5
    MONITOR=$m polybar --reload top 2>/tmp/polybar_"$m" &
done
