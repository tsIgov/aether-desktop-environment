#!/bin/sh

workspace=$(hyprctl activewindow -j | jq -r ".workspace.name")

if [[ $workspace == *"quick"* ]]; then
	destination=$(echo $workspace | awk -F '-' '{print $2}')
else
	destination="special:quick-${workspace}"
fi

hyprctl dispatch movetoworkspacesilent $destination
