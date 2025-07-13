#! /bin/sh
rofi_command=(rofi -dmenu -i -no-show-icons -p)

chosenOption=$(echo -e "  Shutdown\n  Reboot\n⏾  Suspend\n󰜗  Hibernate" | "${rofi_command[@]}" "Power Menu")

case $chosenOption in
	"  Shutdown")
		systemctl shutdown 0
		;;
	"  Reboot")
		systemctl reboot
		;;
	"⏾  Suspend")
		systemctl suspend
		;;
	"󰜗  Hibernate")
		systemctl hibernate
		;;
esac

echo Done
