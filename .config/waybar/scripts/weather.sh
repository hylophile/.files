#!/usr/bin/env sh
# weather information for location based on seen WiFi BSSIDs or IP as fallback

# get close WiFi BSSIDs
# BSSIDS="$(nmcli device wifi list |
#     awk 'NR>1 {if ($1 != "*") {print $1}}' |
#     tr -d ":" |
#     tr "\n" ",")"

# # get geographical location
# LOC=""
# REQUEST_GEO="$(wget -qO - http://openwifi.su/api/v1/bssids/"$BSSIDS")"
# if [ "$(jq ".count_results" <<< "$REQUEST_GEO")" -gt 0 ]; then
#     LAT="$(jq ".lat" <<< "$REQUEST_GEO")"
#     LON="$(jq ".lon" <<< "$REQUEST_GEO")"
#     LOC="$LAT,$LON"
# fi

# get weather information
# text="$(curl -s "https://wttr.in/berlin?format=%t")"

# tooltip="$(curl -s "https://wttr.in/berlin?0QT" |
#     sed 's/\\/\\\\/g' |
#     sed ':a;N;$!ba;s/\n/\\n/g' |
#     sed 's/"/\\"/g')"


temp=$(curl --silent "https://api.brightsky.dev/current_weather?lat=52.52&lon=13.29"|jq ".weather.temperature")

if [ "$(echo "$temp" | head -c 1)" = "-" ]; then
    text="$temp°C"
else
    text="+$temp°C"
fi

# curl "https://api.brightsky.dev/current_weather?lat=52.52&lon=13.29"|jq ".weather.temperature"

# https://www.wetter.de/deutschland/wetter-berlin-18228265.html


# output for Waybar
# if ! grep -q "Unknown location" <<< "$text"; then
    # echo "{\"text\": \"$text\", \"tooltip\": \"<tt>$tooltip</tt>\", \"class\": \"weather\"}"
echo "{\"text\": \"$text\", \"class\": \"weather\"}"
# fi
