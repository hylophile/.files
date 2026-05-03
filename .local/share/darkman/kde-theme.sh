#!/usr/bin/env sh

# Change the global Plasma Theme. On Manjaro you can use "org.manjaro.breath-dark.desktop"
# or "org.manjaro.breath-light.desktop", or you can create your own global Plasma Theme
# with the "Plasma Look And Feel Explorer".
# Reference: https://userbase.kde.org/Plasma/Create_a_Global_Theme_Package
#
# Since Plasma 5.26 the lookandfeeltool does not work anymore without "faking" the screen.
# Reference: https://bugs.kde.org/show_bug.cgi?id=460643

case "$1" in
dark) THEME=org.kde.breezedark.desktop ;;
light) THEME=org.kde.breeze.desktop ;;
default) exit 1 ;;
esac

lookandfeeltool -platform offscreen --apply "$THEME"

