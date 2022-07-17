#!/bin/sh

#textp=$(wl-paste -p | head -c 20|jq -Ra)
#textc=$(wl-paste | head -c 20)
textp=$(wl-paste -p |tr '\n' ' '| head -c 20|jq -Ra | sed 's/^"//;s/"$//')
textc=$(wl-paste |tr '\n' ' '| head -c 20|jq -Ra | sed 's/^"//;s/"$//')

# output for Waybar
echo "{\"text\": \"$textp\t|\t$textc\t\", \"class\": \"clipboard\"}"
