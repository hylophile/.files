#!/usr/bin/env sh

sed -i -E 's/theme = ".+"/theme = "my_flatwhite"/g' ~/.config/helix/config.toml
killall -SIGUSR1 hx
