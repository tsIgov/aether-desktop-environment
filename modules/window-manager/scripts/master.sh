#!/bin/sh

minX=$(hyprctl clients -j | jq "[.[] | select (.floating == false and .workspace.id == $(hyprctl activewindow -j | jq .workspace.id))] | min_by(.at[0]) | .at[0]")
x=$(hyprctl activewindow -j | jq ".at[0]")

if [[ $minX -eq $x ]]; then
	hyprctl dispatch layoutmsg removemaster
else
    hyprctl dispatch layoutmsg addmaster
fi

