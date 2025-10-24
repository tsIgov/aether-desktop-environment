#!/bin/sh
strict_mode() {
    set -T # inherit DEBUG and RETURN trap for functions
    set -C # prevent file overwrite by > &> <>
    set -E # inherit -e
    set -e # exit immediately on errors
    set -u # exit on not assigned variables
    set -o pipefail # exit on pipe failure
}
strict_mode

SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

config_gum() {
	export GUM_TABLE_SELECTED_FOREGROUND="#a6e3a1"

	export GUM_CONFIRM_PROMPT_FOREGROUND="#cdd6f4"
	export GUM_CONFIRM_SELECTED_FOREGROUND="#11111b"
	export GUM_CONFIRM_SELECTED_BACKGROUND="#cba6f7"
	export GUM_CONFIRM_UNSELECTED_FOREGROUND="#cdd6f4"
	export GUM_CONFIRM_UNSELECTED_BACKGROUND="#313244"

	export GUM_FILTER_INDICATOR_FOREGROUND="#a6e3a1"
	export GUM_FILTER_HEADER_FOREGROUND="#a6e3a1"
  	export GUM_FILTER_TEXT_FOREGROUND="#cdd6f4"
	export GUM_FILTER_CURSOR_TEXT_FOREGROUND="#a6e3a1"
  	export GUM_FILTER_MATCH_FOREGROUND="#a6e3a1"
  	export GUM_FILTER_PROMPT_FOREGROUND="#cba6f7"
  	export GUM_FILTER_PLACEHOLDER_FOREGROUND="#a6adc8"
}
config_gum



reset_values() {
	KB_NAME="English (US)"
	KB_LAYOUT="us"
	KB_VARIANT=""

	INTERNET=""

	DISK=""
	START_SECTOR=""
	BOOT_SIZE="512"
	SWAP_SIZE=""
	ROOT_SIZE=""
	ENCRYPTION_PASSWORD=""

	HOSTNAME="AetherOS"
	ROOT_PASSWORD=""
	USERNAME=""
	USER_PASSWORD=""
}



# ================================
# Helpers
# ================================

mask_password() {
	if [[ $# -gt 0 ]]; then
		echo "*******"
	else
		echo ""
	fi
}

screen() {
	local accent_color='\033[0;35m'
	local error_color='\033[0;31m'
	local reset_color='\033[0m'

	clear
	echo -e "${accent_color}<<< $1 >>>${reset_color}" > /dev/tty

	if [[ $# -gt 1 && -n "$2" ]]; then
		echo -e "$2" > /dev/tty
	fi

	if [[ $# -gt 2 && -n "$3" ]]; then
		echo -e "${error_color}$3${reset_color}" > /dev/tty
	fi

	echo
}



# ================================
# Menu
# ================================

menu() {
	local devider="---------------,," arrow="->"
	local option=""

	while [[ "$option" != "Install" && "$option" != "Quit" ]]; do

		screen "Welcome to AetherOS" "This wizzard will guide you through the installation.\nSet your preferences and choose the install button."

		local options=",,\n"
		options="${options}Keyboard layout,${arrow},${KB_NAME}\n"
		options="${options}${devider}\n"

		options="${options}Internet,${arrow},${INTERNET}\n"
		options="${options}${devider}\n"

		options="${options}Disk,${arrow},${DISK}\n"
		if [[ $DISK != "" ]]; then
			options="${options}Start sector,${arrow},${START_SECTOR}\n"
			options="${options}Boot size,${arrow},${BOOT_SIZE}\n"
			options="${options}Swap size,${arrow},${SWAP_SIZE}\n"
			options="${options}Root size,${arrow},${ROOT_SIZE}\n"
			options="${options}Encryption password,${arrow},$(mask_password $ENCRYPTION_PASSWORD)\n"
		fi
		options="${options}${devider}\n"

		options="${options}Hostname,${arrow},${HOSTNAME}\n"
		options="${options}Root password,${arrow},$(mask_password $ROOT_PASSWORD)\n"
		options="${options}Username,${arrow},${USERNAME}\n"
		options="${options}User password,${arrow},$(mask_password $USER_PASSWORD)\n"
		options="${options}${devider}\n"

		options="${options}Install,,\n"
		options="${options}Quit,,\n"

		option=$(echo -e "$options" | gum table -r 1 --no-show-help --hide-count)
		case "$option" in
			"Keyboard layout") keyboard_layout;;
			"Quit") quit;;
		esac
	done
}

keyboard_layout() {
	screen "Choose keyboard layout" "This keyboard layout will be set for the duration of the installer, during the disk unencryption phase during boot and as the default layout of the installed system."

	local chosen
	chosen=$(xkbcli list | yq -r '.layouts[].description' | sort -u | gum filter --height=13) || true

	if [[ $chosen == "" || $chosen == "nothing selected" ]]; then
		return
	fi

	local layout=$(xkbcli list | yq -r ".layouts[] | select(.description == \"$chosen\") | .layout")
	local variant=$(xkbcli list | yq -r ".layouts[] | select(.description == \"$chosen\") | .variant")

	KB_NAME="$chosen"
	KB_LAYOUT="$layout"
	KB_VARIANT="$variant"
}

quit() {
	local result
	clear
	if $(gum confirm "Are you sure you want to exit the installer?" --default=no --no-show-help); then
		exit
	fi

	menu
}



# ================================
# Install
# ================================


# ================================
# Main
# ================================

reset_values
menu


