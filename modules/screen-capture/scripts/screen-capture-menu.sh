#! /bin/sh
rofi_command=(rofi -dmenu -i -no-show-icons -kb-custom-1 "Shift+Return,Shift+KP_Enter" -p)

chosenOption=$(echo -e "󰍹  Screen\n  Window\n󰩬  Region" | "${rofi_command[@]}" "Screen Capture")

if [[ $? -eq 0 ]]; then
	extraArgs="-s --clipboard-only"
else
	mkdir -p "$HOME/Pictures/Screenshots"
	extraArgs="-o $HOME/Pictures/Screenshots"
fi

case $chosenOption in
	"󰍹  Screen")
		hyprshot -m output $extraArgs
		;;
	"  Window")
		hyprshot -m window $extraArgs
		;;
	"󰩬  Region")
		hyprshot -m region $extraArgs
		;;
esac


echo Done
