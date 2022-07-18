#!/usr/bin/env sh


workspaces=$(swaymsg -t get_workspaces)
visible_workspaces=$(echo "$workspaces" | jq ".[] | select(.visible==true).num")
current=$(echo "$workspaces" | jq ".[] | select(.focused==true).num")

for ws in $visible_workspaces
do
    swaymsg "workspace --no-auto-back-and-forth $ws"
    swaymsg move workspace to output left
done

swaymsg "workspace --no-auto-back-and-forth $current"
