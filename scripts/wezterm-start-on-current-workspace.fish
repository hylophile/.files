#!/usr/bin/env fish

set ws (wezterm cli list-clients --format json | jq -r '.[].workspace')

if not string match $ws ""
    wezterm start --workspace $ws
else
    wezterm start
end
