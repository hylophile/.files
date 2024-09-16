#!/usr/bin/env sh

token=$(cat ~/scripts/hass-token)

if [ "$1" = "eingang" ]; then
    curl --silent -X POST \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -d '{"entity_id": "light.wohnzimmer_big"}' \
        "http://192.168.0.52:8123/api/services/light/toggle" >/dev/null &
fi

if [ "$1" = "monitors" ]; then
    curl --silent -X POST \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -d '{"entity_id": "light.monitor_big2"}' \
        "http://192.168.0.52:8123/api/services/light/toggle" >/dev/null &
    curl --silent -X POST \
        -H "Authorization: Bearer $token" \
        -H "Content-Type: application/json" \
        -d '{"entity_id": "light.monitor_big"}' \
        "http://192.168.0.52:8123/api/services/light/toggle" >/dev/null &
fi
