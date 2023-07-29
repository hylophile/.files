#!/usr/bin/env fish

set outputs (swaymsg -t get_outputs | jq -r ".[] |.name")
set bgs (fd . /media/wallpapers/all/)

# killall swaybg

for o in $outputs
    # echo (echo $bgs | tr ' ' '\n' | shuf -n 1)
    # swaymsg output $o bg (echo $bgs | tr ' ' '\n' | shuf -n 1) fill
    swww img -o $o --transition-step 10 (echo $bgs | tr ' ' '\n' | shuf -n 1) &
end
