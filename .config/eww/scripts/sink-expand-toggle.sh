#!/usr/bin/env bash

name="$0"
setting="$1"
delay="$2"

sleep "$delay" && eww update sink-expanded="$setting"
kill $(pgrep -f "bash $name")
