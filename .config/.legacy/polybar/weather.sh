#!/usr/bin/env sh
temp=$(curl --silent "https://api.brightsky.dev/current_weather?lat=52.52&lon=13.29"|jq ".weather.temperature")

if [ "$(echo "$temp" | head -c 1)" = "-" ]; then
    text="$temp°C"
else
    text="+$temp°C"
fi

if [ "$temp" = "null" ]; then
    text=""
fi

echo "$text"
