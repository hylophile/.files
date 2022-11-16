#!/usr/bin/env fish

set output (swaymsg -t get_outputs | jq -r '.[]|select(.focused==true).name')
set bgs (fd . /media/wallpapers/all/)

swww img -o $output --transition-step 10 (echo $bgs | tr ' ' '\n' | shuf -n 1)
