#!/usr/bin/env sh

kb="AT Translated Set 2 keyboard"

if [ $(xinput list-props "$kb" | grep "Device Enabled" | cut -f3) = "1" ]; then
    xinput --disable "$kb"
    xinput --disable "AT Translated Set 2 keyboard"
    xinput --disable "ThinkPad Extra Buttons"
    xinput --disable "SynPS/2 Synaptics TouchPad"
    xinput --disable "TPPS/2 Elan TrackPoint"
    notify-send "❌ Laptop peripherals disabled."
else
    xinput --enable "$kb"
    xinput --enable "AT Translated Set 2 keyboard"
    xinput --enable "ThinkPad Extra Buttons"
    xinput --enable "SynPS/2 Synaptics TouchPad"
    xinput --enable "TPPS/2 Elan TrackPoint"
    notify-send "✅ Laptop peripherals enabled."
fi
