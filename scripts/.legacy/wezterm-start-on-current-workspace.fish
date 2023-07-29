#!/usr/bin/env fish

if pgrep wezterm-gui
    set ws (wezterm cli list-clients --format json | jq -r '.[].workspace')
    wezterm start --workspace $ws
else
    wezterm start
end
