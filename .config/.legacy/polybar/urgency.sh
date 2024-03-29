#!/usr/bin/env sh
names=$(swaymsg -t get_tree | jq -r "recurse(.nodes[]?) | select(.window_properties.instance==\"$1\").name")
match=$(echo "$names" | grep -E -o '\([0-9]+\)')


if [ "$2" = "show" ]; then
    if [ "$match" = "" ]; then
        exit 1
    else
        exit 0
    fi
fi

if [ "$match" != "" ]; then
    echo "%{T2}$2"
else
    echo ""
fi
