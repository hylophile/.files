#!/usr/bin/env fish

set outputs (swaymsg -t get_outputs | jq -r '.[] .name')
set makes (swaymsg -t get_outputs | jq -r '.[] .make')
set i 1

for output in $outputs
    set ewwi (math $i-1)
    set height "100%"

    switch $makes[$i]
        case AU\ Optronics
            # set height 720px
            set height 100%
        case BNQ
            set height 1440px
        case Dell\ Inc.
            set height 100%
    end

    eww open bar --id bar-$output --arg "height=$height" --arg "index=$ewwi" --arg "output=$output"
    sleep 10

    set i (math $i+1)
end
