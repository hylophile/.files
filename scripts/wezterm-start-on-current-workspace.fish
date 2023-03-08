#!/usr/bin/env fish

set ws (wezterm cli list-clients --format json | jq -r '.[].workspace')

if not pgrep wezterm
    wezterm start
else
    wezterm start --workspace $ws
end
