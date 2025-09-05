#! /bin/sh

function screenshot {
	OutputDir="$HOME/Pictures/Screenshots"
	mkdir -p "$OutputDir"

	pkill slurp || hyprshot -m ${1:-region} --raw |
	satty --filename - \
		--output-filename "$OutputDir/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
		--early-exit \
		--actions-on-enter save-to-clipboard \
		--copy-command 'wl-copy'
}

rofi_command=(rofi -dmenu -i -no-show-icons -p)

chosenOption=$(echo -e "󰍹  Screen\n  Window\n󰩬  Region" | rofi -dmenu -i -no-show-icons -p "Screen Capture")

case $chosenOption in
	"󰍹  Screen")
		screenshot output
		;;
	"  Window")
		screenshot window
		;;
	"󰩬  Region")
		screenshot region
		;;
esac
