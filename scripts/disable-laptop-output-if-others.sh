#!/usr/bin/env sh

if [ "$(swaymsg -t get_outputs | jq "length")" != 1 ]; then
    swaymsg output eDP-1 disable
fi
