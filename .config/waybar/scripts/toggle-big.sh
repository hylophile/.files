#!/usr/bin/env sh

current_output=$(swaymsg -t get_outputs | jq '.[] | select(.focused == true)')
name=$(echo "$current_output" | jq '.name')
scale=$(echo "$current_output" | jq '.scale')


if [ "$scale" = "1" ] || [ "$scale" = "1.5" ]; then
    swaymsg output "$name" scale "$(perl -E "say $scale*2")"
else
    swaymsg output "$name" scale "$(perl -E "say $scale/2")"
fi
