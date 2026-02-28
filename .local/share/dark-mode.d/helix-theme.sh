#!/usr/bin/env sh

sed -i -E 's/theme = ".+"/theme = "my_poimandres"/g' ~/.config/helix/config.toml
killall -SIGUSR1 hx
