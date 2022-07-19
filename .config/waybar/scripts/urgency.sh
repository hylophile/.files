#!/usr/bin/env bash

names=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?) | select(.app_id=="firefox-nightly" or .app_id=="telegramdesktop").name')
match=$(echo "$names" | grep -E -o '\([0-9]+\)')

if [ "$1" = "show" ]; then
    if [ "$match" = "" ]; then
        exit 1
    else
        exit 0
    fi
fi

echo "{\"text\": \"🦄\", \"class\": \"urgent\"}"
