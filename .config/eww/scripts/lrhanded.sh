#!/usr/bin/env bash

if [ "$1" = "toggle" ]; then
    left_handed=$(swaymsg -t get_inputs | jq -r '.[] | select(.type == "pointer" and .libinput.left_handed != null) | .libinput.left_handed' | head -1)
    if test "$left_handed" = disabled; then
        swaymsg input type:pointer left_handed enabled
    else
        swaymsg input type:pointer left_handed disabled
    fi
else
    swaymsg -t subscribe -m '["input"]' | jq --raw-output --compact-output --unbuffered '.input.libinput.left_handed'
fi
