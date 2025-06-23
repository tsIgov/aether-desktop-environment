#!/bin/sh

workspace=$(hyprctl activewindow | grep "workspace:" | awk '{print $3}' | cut -c2- | rev | cut -c2- | rev)

if [[ $workspace == *"quick"* ]]; then
	destination=$(echo $workspace | awk -F '-' '{print $2}')
else
	destination="special:quick-${workspace}"
fi

hyprctl dispatch movetoworkspacesilent $destination
