#!/bin/sh

current=$(hyprctl activewindow -j | jq -r '.floating')

if [ "$current" == "true" ]; then
    hyprctl dispatch focuswindow tiled
else
    hyprctl dispatch focuswindow floating
fi
