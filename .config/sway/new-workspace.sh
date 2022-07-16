#!/usr/bin/env sh
workspaces=$(swaymsg -t get_workspaces | jq ".[] .num" | sort -g)
new_workspace=-1

for i in $(seq 1 10)
do
    if ! echo "$workspaces" | grep --quiet "$i\$"; then
        new_workspace=$i
        break
    fi
done

if [ "$new_workspace" != -1 ]; then
    swaymsg workspace "$new_workspace"
fi
