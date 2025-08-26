#!/bin/sh

current=$(hyprctl activewindow -j | jq -r '.floating')

if [ "$current" == "true" ]; then
    case "$1" in
		l)
			X=-50
			Y=0
		;;
		r)
			X=50
			Y=0
		;;
		u)
			X=0
			Y=-50
		;;
		d)
			X=0
			Y=50
		;;
	esac

	hyprctl dispatch moveactive $X $Y
else
    hyprctl dispatch movewindoworgroup $1
fi
