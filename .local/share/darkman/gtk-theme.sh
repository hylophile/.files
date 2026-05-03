#!/usr/bin/env sh

# The names for the Arc theme variations are ambiguous:
# "Darker" is actually LESS DARK than "Dark".

case "$1" in
dark) ICON=Arc-Dark ;;
light) ICON=Arc-Darker ;;
default) exit 1 ;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$ICON"
gsettings set org.gnome.desktop.interface color-scheme "prefer-$1"
