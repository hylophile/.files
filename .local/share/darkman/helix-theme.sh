#!/usr/bin/env sh

case "$1" in
dark) THEME=my_poimandres ;;
light) THEME=my_flatwhite ;;
default) exit 1 ;;
esac

sed -i -E "s/theme = \".+\"/theme = \"${THEME}\"/g" ~/.config/helix/config.toml
killall -SIGUSR1 hx
