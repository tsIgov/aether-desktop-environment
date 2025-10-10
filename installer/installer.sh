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

ERROR_COLOR='\033[0;31m'
ACCENT_COLOR='\033[0;35m'
RESET_COLOR='\033[0m'

MIN_SWAP_SIZE_GIB=1
MIN_PART_SIZE_GIB=50

GUM_SEPARATOR="---------"

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

choose_unallocated_space() {
	local csv=$(echo -e "Device,Start sector,End sector,Number of sectors,Size")
	local devices=$(lsblk -ndAo NAME)

	for device in $devices; do
		local sector_size=$(get_sector_size_bytes "$device")
		local data=$(sudo parted -m "/dev/$device" unit s print free | awk -F: -v ss="$sector_size" -v dv="$device" '
			$1 ~ /^[0-9]+$/ && $5 == "free;" {
				start = substr($2, 1, length($2)-1)
				end   = substr($3, 1, length($3)-1)
				num   = substr($4, 1, length($4)-1)
				size_bytes = num * ss
				size_mib = size_bytes / 1024 / 1024 /1024
				printf "%s,%d,%d,%d,%.2f GiB\n", dv, start, end, num, size_mib
			}')
		csv="$csv\n$data"
	done

	csv="$csv\n$GUM_SEPARATOR,,,,\nBack,,,,"

	echo -e "$csv" | gum_wrapper table
}

get_ram_bytes() {
	awk '/MemTotal/ {print $2 * 1024}' /proc/meminfo
}

get_sector_size_bytes() {
	cat /sys/block/$(basename "$1")/queue/hw_sector_size
}

min_int() {
	echo $(( $1 < $2 ? $1 : $2 ))
}

max_int() {
	echo $(( $1 > $2 ? $1 : $2 ))
}

ceil() {
  awk -v n="$1" 'BEGIN { print (n == int(n)) ? n : int(n) + (n > 0) }'
}

floor() {
  awk -v n="$1" 'BEGIN { print (n == int(n)) ? n : int(n) - (n < 0) }'
}

sectors_to_gib() {
	local sectors sector_size
	sectors=$1
	sector_size=$2

	awk "BEGIN {
		res = $sector_size * $sectors / 1024 / 1024 / 1024
  		printf \"%.2f\", res
	}"
}

gib_to_sectors() {
	local gib sector_size
	gib=$1
	sector_size=$2

	awk "BEGIN {
		res = $gib * 1024 * 1024 * 1024 / $sector_size
  		printf \"%d\", res
	}"
}

choose_allocation_size() {
	local result title
	local min_size_sectors default_size_sectors max_size_sectors sector_size_bytes
	local min_size_gib default_size_gib max_size_gib

	local invalid_number_message="${ERROR_COLOR}Invalid value (must be a valid number in the specified range).${RESET_COLOR}"

	min_size_sectors=$1
	default_size_sectors=$2
	max_size_sectors=$3
	sector_size_bytes=$4
	title="$5"

	default_size_sectors=$(min_int $default_size_sectors $max_size_sectors)
	default_size_sectors=$(max_int $default_size_sectors $min_size_sectors)

	min_size_gib=$(sectors_to_gib $min_size_sectors $sector_size_bytes)
	default_size_gib=$(sectors_to_gib $default_size_sectors $sector_size_bytes)
	max_size_gib=$(sectors_to_gib $max_size_sectors $sector_size_bytes)

	local subtitle="Choose a size between ${min_size_gib} GiB and ${max_size_gib} GiB (write the number only).\nType 0 to go back."

	if [[ $min_size_sectors -gt $max_size_sectors ]]; then
		clear > /dev/tty
		echo -e "$title" > /dev/tty
		echo -e "${ERROR_COLOR}The selected unallocated space is less than the required minimum of $min_size_gib GiB ${RESET_COLOR}" > /dev/tty

		result=$(gum_wrapper choose "Back")
		echo 0
		return
	else
		clear > /dev/tty
		echo -e "$title" > /dev/tty
		echo -e  "$subtitle" > /dev/tty

		while true; do
			result=$(gum_wrapper input --placeholder "Size in GiB" --value "$default_size_gib" )

			if [[ "$result" == "0" ]]; then
				echo 0
				return
			fi

			local number_regex='^-?[0-9]*.?[0-9]+$'
			if [[ ! $result =~ $number_regex ]]; then
				clear > /dev/tty
				echo -e "$title" > /dev/tty
				echo -e "$subtitle" > /dev/tty
				echo -e "$invalid_number_message" > /dev/tty
				continue
			fi

			result=$(awk "BEGIN { printf \"%.2f\", $result }")

			if awk "BEGIN {exit !($result < $min_size_gib || $result > $max_size_gib)}"; then
				clear > /dev/tty
				echo -e "$title" > /dev/tty
				echo -e "$subtitle" > /dev/tty
				echo -e "$invalid_number_message" > /dev/tty
				continue
			fi

			if [[ "$result" == "$max_size_gib" ]]; then
				echo $max_size_sectors
				return
			fi

			result=$(gib_to_sectors $result $sector_size_bytes)
			echo "$result"
			return
		done
	fi
}


# ================================

welcome() {
	local option

	clear

	echo -e "${ACCENT_COLOR}<<< Welcome to AetherOS >>>${RESET_COLOR}"
	echo -e "This wizzard will guide you through the installation."

	option=$(gum_wrapper choose "Continue" "Exit")

	case "$option" in
		"Continue")
			keep_sudo
			setup_internet
			exit
			;;
		"Exit")
			clear
			exit
			;;
	esac
}

setup_internet() {
	local option
	local title="${ACCENT_COLOR}<<< Setup internet connection >>>${RESET_COLOR}"
	local subtitle="The installer requires internet connection to so you need to set it up."

	clear
	echo -e "$title"
	echo -e "$subtitle"

	option=$(gum_wrapper choose "Continue" "Back")
	case "$option" in
		"Continue")
			nmtui
			while ! gum spin --spinner meter --title "Checking internet connection..." -- ping -c 4 -W 10 github.com; do
				clear
				echo -e "$title"
				echo -e "${ERROR_COLOR}Could not get response form github.com.${RESET_COLOR}"
				option=$(gum_wrapper choose "Retry" "Back")

				case "$option" in
					"Retry")
						clear
						echo -e "$title"
						echo -e "$subtitle"
						;;
					"Back")
						clear
						echo -e "$title"
						echo -e "$subtitle"
						nmtui
					;;
				esac
			done
			setup_disk
			exit
			;;
		"Back")
			welcome
			exit
			;;
	esac
}

setup_disk() {
	local title="${ACCENT_COLOR}<<< Setup disk >>>${RESET_COLOR}"
	local subtitle="Select a disk to unallocate space for AetherOS and then continue."
	local disks
	local option

	clear
	echo -e "$title"
	echo -e "$subtitle"

	disks=$(lsblk -ndAo NAME,SIZE,MODEL)
	option=$(echo -e "$disks\n${GUM_SEPARATOR}\nContinue\nBack" | gum_wrapper choose --header "Choose a disk:")

	case "$option" in
		"Continue")
			setup_swap
			exit
		;;
		"Back")
			setup_internet
			exit
		;;
		*)
			local disk=$(echo $option | awk '{print $1;}')
			disk="/dev/$disk"
			sudo cfdisk $disk
			setup_disk
			exit
		;;
	esac
}

setup_swap() {
	local title="${ACCENT_COLOR}<<< Setup swap >>>${RESET_COLOR}"
	local option chosen_size_sectors=0
	local disk start_sector sector_count sector_size_bytes ram_bytes ram_sectors min_swap

	clear
	echo -e "$title"

	if swapon --show | grep -q '^' && false; then
		echo -e "You already have a swap space enabled."

		option=$(gum_wrapper choose "Continue" "Back")
		case "$option" in
		"Continue")
			allocate_space
			exit
		;;
		"Back")
			setup_disk
			exit
		;;
		esac
	else
		echo -e "You don't have a swap space enabled. Do you want to create a swap disk?"
		option=$(gum_wrapper choose "Yes" "No" "Back" )
		case "$option" in
			"Yes")
			;;
			"No")
				allocate_space
				exit
			;;
			"Back")
				setup_disk
				exit
			;;
		esac

		while [[ $chosen_size_sectors == "0" ]]; do
			clear
			echo -e "$title"
			echo -e "Choose unallocated space to create your swap disk."

			option=$(choose_unallocated_space)
			disk=$(echo "$option" | awk -F',' '{print $1}')
			case "$disk" in
				"Back")
					setup_disk
					exit
				;;
			esac


			start_sector=$(echo "$option" | awk -F',' '{print $2}')
			sector_count=$(echo "$option" | awk -F',' '{print $4}')

			sector_size_bytes=$(get_sector_size_bytes "$disk")

			ram_bytes=$(get_ram_bytes)
			ram_sectors=$(( ($sector_size_bytes + $ram_bytes - 1) / $sector_size_bytes ))

			min_swap=$(awk "BEGIN {print $MIN_SWAP_SIZE_GIB * 1024 * 1024 * 1024 / $sector_size_bytes}")
			min_swap=$(ceil $min_swap)

			chosen_size_sectors=$(choose_allocation_size $min_swap $ram_sectors $sector_count $sector_size_bytes "$title")
		done

		sudo parted -s "/dev/$disk" mkpart primary linux-swap "$start_sector"s $(( $start_sector + $chosen_size_sectors - 1 ))s
		local new_part
		new_part=$(lsblk -nrpo NAME,TYPE "/dev/$disk" | awk '$2=="part" {print $1}' | tail -n1)
		sudo mkswap "/dev/$new_part"
		sudo swapon "/dev/$new_part"

		# bytes in parted are denoted with B, sectors with s
		# start and end are the distance from the start of the disk
		# end is inclusive
	fi
}

allocate_space() {
	exit
}

# welcome
setup_swap

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


test=$(sudo parted -m "$DEVICE" unit s print free | awk -F: -v ss="$SECTOR_SIZE" '
$1 ~ /^[0-9]+$/ && $5 == "free;" {
    start = substr($2, 1, length($2)-1)
    end   = substr($3, 1, length($3)-1)
    num   = substr($4, 1, length($4)-1)
    size_bytes = num * ss
    size_mb = size_bytes / 1024 / 1024
    size_gb = size_bytes / 1024 / 1024 / 1024
    printf "%-15d,%-15d,%-15d,%-15.2f,%-15.3f\n", start, end, num, size_mb, size_gb
}')
echo -e "Start sector,End sector,Number of sectors,Size MB,Size GB\n$test" | gum table

#qmain
exit 0

if swapon --show | grep -q '^'; then
    echo "✅ Swap is enabled:"
    swapon --show
else
    echo "❌ No swap is enabled."
fi

lsblk -d -o NAME | tail -n+2






clear
echo "=== Network setup ==="
dialog --backtitle "NixOS custom installer" --title "Networking" --yesno "Would you like to configure networking (Wi-Fi / manual) with nmtui?" 8 60
if [ $? -eq 0 ]; then
  clear
  #nmtui
fi

# verify connectivity
clear
echo "Checking network connectivity..."
if ! ping -c 1 -W 10 google.com >/dev/null 2>&1; then
  dialog --backtitle "NixOS custom installer" --title "No internet" --msgbox "No internet connection detected. Open nmtui to configure network." 8 60
  exec /bin/sh
fi
dialog --backtitle "NixOS custom installer" --msgbox "Network appears up." 6 50

# Select disk
DISK_CHOICE=$(lsblk -ndo NAME,SIZE,MODEL | sed 's/  */|/g' | awk -F'|' '{ printf "%s %s\n", $1, $2 }' )
# Build menu list
MENU=()
while read -r line; do
  name=$(echo "$line" | awk '{print $1}')
  size=$(echo "$line" | awk '{print $2}')
  MENU+=("$name" "$size")
done <<EOF
$DISK_CHOICE
EOF

# dialog menu requires at least one item
if [ ${#MENU[@]} -eq 0 ]; then
  dialog --msgbox "No disks found. Exiting." 6 40
  exit 1
fi

# Display menu (max 10 options displayed)
CHOICE=$(dialog --backtitle "NixOS custom installer" --title "Select target disk" --menu "Choose disk to install onto (all data will be erased):" 20 70 10 "${MENU[@]}" 2> /tmp/.dlg && cat /tmp/.dlg)
if [ -z "$CHOICE" ]; then
  dialog --msgbox "No disk chosen. Exiting." 6 40
  exit 1
fi

DISK="/dev/$CHOICE"
clear
dialog --backtitle "NixOS custom installer" --title "Confirm" --yesno "All data on $DISK will be destroyed. Continue?" 8 60
if [ $? -ne 0 ]; then
  dialog --msgbox "Aborted by user." 6 40
  exit 1
fi

# Prompt for hostname, username, password (password will be used for LUKS too)
HOSTNAME=$(dlg_input "Hostname" "Enter the hostname for the installed system:")
USERNAME=$(dlg_input "Username" "Enter the username to create:")

# Get password twice
PASSWORD1=$(dlg_password "Password" "Enter password (this will be used for LUKS and the user):")
PASSWORD2=$(dlg_password "Password" "Confirm password:")
if [ "$PASSWORD1" != "$PASSWORD2" ]; then
  dialog --msgbox "Passwords do not match. Restart the installer." 6 40
  exit 1
fi
PASSWORD="$PASSWORD1"
unset PASSWORD1 PASSWORD2

# Wipe and partition the disk: EFI (1) + LUKS root (2)
clear
echo "Wiping $DISK..."
wipefs -a "$DISK" || true

# Create GPT with parted (very basic)
parted --script "$DISK" mklabel gpt
parted --script "$DISK" mkpart primary fat32 1MiB 512MiB
parted --script "$DISK" set 1 esp on
parted --script "$DISK" mkpart primary 512MiB 100%

EFI_PART="${DISK}1"
ROOT_PART="${DISK}2"

# Format EFI
mkfs.vfat -n EFI "$EFI_PART"

# Setup LUKS using the same password (read passphrase from stdin)
# use --batch-mode and --key-file=- to avoid interactive prompt
printf '%s' "$PASSWORD" | cryptsetup luksFormat --type luks2 "$ROOT_PART" --key-file=- --batch-mode
# open the container
printf '%s' "$PASSWORD" | cryptsetup open "$ROOT_PART" cryptroot --key-file=-

# Make filesystem inside LUKS (adjust to your preferred fs)
mkfs.ext4 -L nixos /dev/mapper/cryptroot

# Mount
mount /dev/mapper/cryptroot /mnt
mkdir -p /mnt/boot
mount "$EFI_PART" /mnt/boot

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
