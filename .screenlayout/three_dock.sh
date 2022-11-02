#!/bin/sh

aoc=$(xrandr --props | rg 2e1a010380351e782a6435a5544f9e27 -B 3 | awk 'NR==1{print $1}')
benq=$(xrandr --props | rg 231e0103804627782e5995af4f42af26 -B 3 | awk 'NR==1{print $1}')

xrandr \
    --output eDP --primary --mode 1920x1080 --pos 480x2700 --rotate normal --scale 1.5x1.5 \
    --output "$aoc" --mode 1920x1080 --pos 0x540 --rotate normal --scale 2x2 \
    --output "$benq" --mode 3840x2160 --pos 3840x0 --rotate normal --scale 1.25x1.25
