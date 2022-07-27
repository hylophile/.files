#!/usr/bin/env sh

output=$(swaymsg -t get_outputs| jq '.[] | select(.model == "2460G4")')
name=$(echo "$output" | jq '.name')
is_turned_on=$(echo "$output" | jq '.dpms')

if [ "$1" = "toggle" ]; then
    swaymsg output "$name" dpms toggle
    exit
fi

if grep --silent rook /etc/hostname; then
    if [ "$is_turned_on" = "false" ]; then
        echo "{\"text\": \"\", \"class\": \"dpms\"}"
    else
        echo "{\"text\": \"\", \"class\": \"dpms\"}"
    fi
fi
