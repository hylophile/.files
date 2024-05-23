#!/usr/bin/env bash

url="$1"

file_path=$(echo "$url" | sed -n 's|^file://\([^?]*\).*|\1|p')
line=$(echo "$url" | sed -n 's|.*[?&]line=\([^&]*\).*|\1|p')
column=$(echo "$url" | sed -n 's|.*[?&]column=\([^&]*\).*|\1|p')

hx_command="hx $file_path:$line:$column"

echo "$hx_command"
