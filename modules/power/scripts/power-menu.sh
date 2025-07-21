#! /bin/sh
rofi_command=(rofi -dmenu -i -no-show-icons -p)

chosenOption=$(echo -e "  Shutdown\n  Reboot\n󰍃  Logout\n⏾  Suspend\n󰜗  Hibernate" | "${rofi_command[@]}" "Power Menu")

case $chosenOption in
	"  Shutdown")
		systemctl poweroff
		;;
	"  Reboot")
		systemctl reboot
		;;
	"󰍃  Logout")
		hyprctl dispatch exit
		;;
	"⏾  Suspend")
		systemctl suspend
		;;
	"󰜗  Hibernate")
		systemctl hibernate
		;;
esac

echo Done
