#!/bin/sh
strict_mode(){
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


BOOT_SIZE_MIB=512
MIN_SWAP_SIZE_MIB=512 #1024
MIN_ROOT_SIZE_MIB=512 #204800

DISK=""
SECTORS_PER_MIB=""
START_SECTOR=""
TOTAL_SIZE_MIB=""
SWAP_SIZE_MIB=""

ENCRYPTION_PASSWORD=""
ROOT_PASSWORD=""
USER_PASSWORD=""

HOSTNAME=""
USERNAME=""


keep_sudo() {
	sudo -v

	# Keep the sudo timestamp updated until the script finishes
	# (runs in the background)
	while true; do
		sudo -n true
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &
}

screen() {
	local accent_color='\033[0;35m'
	local error_color='\033[0;31m'
	local reset_color='\033[0m'

	clear > /dev/tty
	echo -e "${accent_color}<<< $1 >>>${reset_color}" > /dev/tty

	if [[ $# -gt 1 && -n "$2" ]]; then
		echo -e "$2" > /dev/tty
	fi

	if [[ $# -gt 2 && -n "$3" ]]; then
		echo -e "${error_color}$3${reset_color}" > /dev/tty
	fi
}

run() {
	local scriptName=$1
	shift 1
	sudo sh -c "source \"$SCRIPT_DIR/$scriptName\" \"\$@\"" _ "$@"
}



# ================================
# Math
# ================================

min_int() {
	echo $(( $1 < $2 ? $1 : $2 ))
}

max_int() {
	echo $(( $1 > $2 ? $1 : $2 ))
}



# ================================
# Gum
# ================================

GUM_SEPARATOR="---------"

gum_wrapper() {
	local result=""
	local args=("$@")
	local stdin_data=""
	local status

    if [ ! -t 0 ]; then
        stdin_data=$(cat -)
    fi

	echo > /dev/tty

	while [[ "$result" == "" || "$result" =~ ^"$GUM_SEPARATOR" ]]; do
		if result=$(echo -e "$stdin_data" | gum "${args[@]}"); then
			if [[ ( ! "$result" =~ ^"$GUM_SEPARATOR") && "$result" != "" ]]; then
				break
			fi
		else
			local status=$?
			if [[ $status -ne 1 ]]; then
				return $status
			else
				printf "\033[1A\033[2K" > /dev/tty
				result=""
			fi
		fi
	done

	echo $result
}

gum_spin() {
	local title=$1 scriptName=$2
	shift 2
	sudo -v
	gum spin --spinner meter --title="$title" --show-output -- sudo sh -c "source \"$SCRIPT_DIR/$scriptName\" \"\$@\"" _ "$@"
}

choose_unallocated_space() {
	local csv=$(echo -e "Device,Start sector,End sector,Size (MiB)")
	local devices=$(lsblk -ndAo NAME)


	for device in $devices; do
		local data sectors_per_mib
		sectors_per_mib=$(get_sectors_per_mib $device)
		data=$(sudo parted -m "/dev/$device" unit s print free | awk -F: -v dv="$device" -v spm="$sectors_per_mib" '
			$1 ~ /^[0-9]+$/ && $5 == "free;" {
				start = substr($2, 1, length($2)-1)
				start = int((start + spm - 1) / spm) * spm

				end = substr($3, 1, length($3)-1)
				end = int(end / spm) * spm

				size = (end - start + 1) / spm
				if (size >= 10) {
					printf "%s,%d,%d,%d\n", dv, start, end, size
				}
			}')
		csv="$csv\n$data"
	done

	csv="$csv\n$GUM_SEPARATOR,,,\nManage disks,,,\nBack,,,"

	echo -e "$csv" | gum_wrapper table
}

choose_allocation_size() {
	local result title
	local min_size_mib default_size_mib max_size_mib

	local invalid_number_message="Invalid value (must be a valid number in the specified range)."

	min_size_mib=$1
	default_size_mib=$2
	max_size_mib=$3
	title="$4"

	default_size_mib=$(min_int $default_size_mib $max_size_mib)
	default_size_mib=$(max_int $default_size_mib $min_size_mib)

	local subtitle="Choose a size between ${min_size_mib} MiB and ${max_size_mib} MiB (write the number only).\nType 0 to go back."

	if [[ $min_size_mib -gt $max_size_mib ]]; then
		screen "$title" "" "The selected unallocated space is less than the required minimum of $min_size_mib MiB."
		result=$(gum_wrapper choose "Back")
		echo 0
		return
	fi

	screen "$title" "$subtitle"

	while true; do
		result=$(gum_wrapper input --placeholder "Size in MiB" --value "$default_size_mib" )

		if [[ "$result" == "0" ]]; then
			echo 0
			return
		fi

		local number_regex='^[1-9]?[0-9]*$'
		if [[ ! $result =~ $number_regex ]]; then
			screen "$title" "$subtitle" "$invalid_number_message"
			continue
		fi

		result=$(awk "BEGIN { printf \"%d\", $result }")

		if awk "BEGIN {exit !($result < $min_size_mib || $result > $max_size_mib)}"; then
			screen "$title" "$subtitle" "$invalid_number_message"
			continue
		fi

		echo "$result"
		return
	done
}

choose_password() {
	local title="$1" subtitle="$2"
	local password="" password_repeat="" option

	while [[ -z "$password" || -z "$password_repeat" || "$password" != "$password_repeat" ]]; do
		screen "$title" "$subtitle"
		password=$(gum_wrapper input --password --placeholder "Type your password...")
		screen "$title" "$subtitle"
		password_repeat=$(gum_wrapper input --password --placeholder "Repeat your password...")

		if [[ "$password" == "$password_repeat" ]]; then
			echo "$password"
			return
		fi

		screen "$title" "$subtitle" "Passwords do not match."
		option=$(gum_wrapper choose "Try again" "Back")
		case "$option" in
			"Try again")
				continue
				;;
			"Back")
				return
				;;
		esac

	done
}


# ================================
# Disk utils
# ================================

get_ram_mib() {
	awk '/MemTotal/ {printf "%d", $2 / 1024}' /proc/meminfo
}

get_sectors_per_mib() {
	local bytes_per_sector
	bytes_per_sector=$(cat /sys/block/$(basename "$1")/queue/hw_sector_size)
	awk -v bps=$bytes_per_sector 'BEGIN {printf "%d", 1024 * 1024 / bps}'
}



# ================================
# Screens
# ================================

welcome_screen() {
	local option

	screen "Welcome to AetherOS" "This wizzard will guide you through the installation."

	option=$(gum_wrapper choose "Continue" "Exit")
	case "$option" in
		"Continue")
			keep_sudo
			setup_internet_screen
			return
			;;
		"Exit")
			clear
			exit
			;;
	esac
}

setup_internet_screen() {
	local option error
	local title="Setup internet connection"

	screen "$title" ""

	if error=$(gum_spin "Checking internet connection..." "check-internet.sh"); then
		setup_disk_screen
		exit
	fi

	screen "$title" "" "$error"

	option=$(gum_wrapper choose "Retry" "Configure" "Back")
	case "$option" in
		"Retry")
			setup_internet_screen
			exit
			;;
		"Configure")
			nmtui
			setup_internet_screen
			exit
		;;
		"Back")
			welcome_screen
			exit
		;;
	esac
}

setup_disk_screen() {
	local min_size_mib=$(( $MIN_ROOT_SIZE_MIB + $BOOT_SIZE_MIB ))
	local title="Setup disk"

	screen "$title" "Choose unallocated space for AetherOS."

	option=$(choose_unallocated_space)
	DISK=$(echo "$option" | awk -F',' '{print $1}')
	case "$DISK" in
		"Manage disks")
			manage_disks_screen
			setup_disk_screen
			return
		;;
		"Back")
			welcome_screen
			return
		;;
	esac

	local size_mib
	SECTORS_PER_MIB=$(get_sectors_per_mib $DISK)

	START_SECTOR=$(echo "$option" | awk -F',' '{print $2}')
	size_mib=$(echo "$option" | awk -F',' '{print $4}')

	TOTAL_SIZE_MIB=$(choose_allocation_size $min_size_mib $size_mib $size_mib "$title")
	if [[ $TOTAL_SIZE_MIB == 0 ]]; then
		setup_disk_screen
		return
	fi

	setup_swap_screen
	return
}

setup_swap_screen() {
	local title="Setup swap" option
	screen "$title" "Do you want to reserve some of this space for swap?"

	option=$(gum_wrapper choose "Yes" "No" "Back" )
	case "$option" in
		"Yes")
			choose_swap_size_screen
			return
		;;
		"No")
			setup_encryption_screen
			return
		;;
		"Back")
			setup_disk_screen
			return
		;;
	esac
}

choose_swap_size_screen() {
	local title="Setup swap"

	local max_size_mib ram_mib
	max_size_mib=$(( $TOTAL_SIZE_MIB - $BOOT_SIZE_MIB - $MIN_ROOT_SIZE_MIB ))
	ram_mib=$(get_ram_mib)


	SWAP_SIZE_MIB=$(choose_allocation_size $MIN_SWAP_SIZE_MIB $ram_mib $max_size_mib "$title")
	if [[ $SWAP_SIZE_MIB == 0 ]]; then
		setup_swap_screen
		return
	fi

	setup_encryption_screen
	return
}

setup_encryption_screen() {
	local title="Disk encryption"
	ENCRYPTION_PASSWORD=$(choose_password "$title" "Choose a password for disk encryption.")
	if [[ -z "$ENCRYPTION_PASSWORD" ]]; then
		setup_swap_screen
		return
	fi

	configure_os_screen
	return
}

manage_disks_screen() {
	local title="Select disk" subtitle="Select a disk to manage."
	local disks disk option
	while true; do
		screen "$title" "$subtitle"

		disks=$(lsblk -ndAo NAME,SIZE,MODEL)

		option=$(echo -e "$disks\n${GUM_SEPARATOR}\nContinue" | gum_wrapper choose --header "Choose a disk:")
		case "$option" in
			"Continue")
				return
			;;
			*)
				disk=$(echo $option | awk '{print $1;}')
				disk="/dev/$disk"
				sudo cfdisk $disk
			;;
		esac
	done
}

configure_os_screen() {
	screen "Configure" ""
	install
}

fail_screen() {
	local title="Installation failed" option
	echo -e "\033[0;31m\n<<< $title >>>\033[0m" > /dev/tty

	option=$(gum_wrapper choose "Start again" "Exit" )
	case "$option" in
		"Start again")
			welcome_screen
			return
		;;
		"Exit")
			clear
			exit
		;;
	esac
}



# ================================
# Installation
# ================================

install() {
	screen "Setting up disk"
	if ! run "partition-disk.sh" $DISK $START_SECTOR $TOTAL_SIZE_MIB $SWAP_SIZE_MIB $BOOT_SIZE_MIB $SECTORS_PER_MIB $ENCRYPTION_PASSWORD; then
		fail_screen
		exit
	fi
}




# ================================
# Main
# ================================

# systemctl --user stop udiskie.service

#welcome_screen

keep_sudo
setup_disk_screen
exit 0





# is_valid_hostname() {
#     local hostname="$1"

#     # Must not exceed 253 characters
#     [[ ${#hostname} -le 253 ]] || return 1

#     # Regex for valid hostname
#     local regex='^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)(\.([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?))*$'

#     [[ $hostname =~ $regex ]]
# }

# if is_valid_hostname "asd@f"; then
#     echo "✅ is a valid hostname"
# else
#     echo "❌ is NOT a valid hostname"
# fi















# Prepare /mnt/etc/nixos (copy templates from ISO)
mkdir -p /mnt/etc/nixos
if [ -d /etc/nixos ] ; then
  cp -r /etc/nixos/* /mnt/etc/nixos/ 2>/dev/null || true
fi

# Let user edit predefined files (if any). If no files exist, create a minimal configuration.nix
if ! ls /mnt/etc/nixos/*.nix >/dev/null 2>&1; then
  cat > /mnt/etc/nixos/configuration.nix <<'EOF'
{ config, pkgs, ... }:
{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];
  networking.hostName = "nixos";
  time.timeZone = "UTC";
  environment.systemPackages = with pkgs; [ vim ];
  services.openssh.enable = true;
}
EOF
fi

# Allow user to edit files with nano
for f in /mnt/etc/nixos/*.nix; do
  dialog --backtitle "NixOS custom installer" --title "Edit" --yesno "Would you like to edit $(basename "$f")?" 7 60
  if [ $? -eq 0 ]; then
    nano "$f"
  fi
done

# Generate hashed password for NixOS config (SHA-512)
# openssl passwd -6 generates an SHA-512 crypt hash
HASHED_PASS=$(openssl passwd -6 "$PASSWORD")

# Append / merge our settings into configuration.nix
# We'll create a small file that the user config can import, to avoid clobbering edits
cat > /mnt/etc/nixos/installer-generated.nix <<EOF
{ config, pkgs, ... }:
{
  networking.hostName = "${HOSTNAME}";

  users.users.${USERNAME} = {
    isNormalUser = true;
    initialHashedPassword = "${HASHED_PASS}";
    extraGroups = [ "wheel" ];
  };

  # EFI + systemd-boot on UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Tell bootinit about the LUKS root device so the installed system can unlock it
  boot.initrd.luks.devices = {
    cryptroot = {
      device = "${ROOT_PART}";
      # If you used LVM under LUKS, set preLVM = true;
    };
  };
}
EOF

# Ensure the main configuration imports installer-generated.nix
MAIN_CFG=/mnt/etc/nixos/configuration.nix
if ! grep -q 'installer-generated.nix' "$MAIN_CFG"; then
  cat >> "$MAIN_CFG" <<'EOF'

# Include the installer-generated configuration (hostname, users, LUKS)
((import ./installer-generated.nix) {})
EOF
fi

# Install NixOS
clear
dialog --backtitle "NixOS installer" --title "Proceed" --yesno "Ready to run nixos-install and install the system to $DISK? (This will run as root and may take time.)" 8 60
if [ $? -ne 0 ]; then
  dialog --msgbox "Install aborted." 6 40
  exit 1
fi

nixos-generate-config --root /mnt # TODO copy the hardware config file

# Run nixos-install; this will read the configuration under /mnt/etc/nixos
nixos-install --root /mnt --no-root-passwd

# After install, close LUKS and offer reboot
cryptsetup close cryptroot || true

dialog --backtitle "NixOS installer" --title "Done" --msgbox "Installation complete. Reboot now." 7 50
reboot



# nix-shell -p libxkbcommon yq
#xkbcli list | yq -r '.layouts[] | "\(.layout),\(.variant),\(.description)"'


# # hex-to-rgb.nix
# { hex }:

# let
#   # Helper function: convert two hex digits to an integer
#   fromHex = h: builtins.fromJSON ("0x" + h);

#   # Ensure the input is uppercase and strip a leading "#", if present
#   cleanHex = builtins.replaceStrings ["#"] [""] (builtins.toUpper hex);

#   r = fromHex (builtins.substring 0 2 cleanHex);
#   g = fromHex (builtins.substring 2 2 cleanHex);
#   b = fromHex (builtins.substring 4 2 cleanHex);
# in
# "${toString r}, ${toString g}, ${toString b}"
