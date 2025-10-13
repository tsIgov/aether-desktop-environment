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



# ================================
# Math
# ================================

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

choose_unallocated_space() {
	local csv=$(echo -e "Device,Start sector,End sector,Number of sectors,Size")
	local devices=$(lsblk -ndAo NAME)

	for device in $devices; do
		local sector_size data
		sector_size=$(get_sector_size_bytes "$device")
		data=$(sudo parted -m "/dev/$device" unit s print free | awk -F: -v ss="$sector_size" -v dv="$device" '
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

choose_allocation_size() {
	local result title
	local min_size_sectors default_size_sectors max_size_sectors sector_size_bytes
	local min_size_gib default_size_gib max_size_gib

	local invalid_number_message="Invalid value (must be a valid number in the specified range)."

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
		screen "$title" "" "The selected unallocated space is less than the required minimum of $min_size_gib GiB."
		result=$(gum_wrapper choose "Back")
		echo 0
		return
	fi

	screen "$title" "$subtitle"

	while true; do
		result=$(gum_wrapper input --placeholder "Size in GiB" --value "$default_size_gib" )

		if [[ "$result" == "0" ]]; then
			echo 0
			return
		fi

		local number_regex='^-?[0-9]*.?[0-9]+$'
		if [[ ! $result =~ $number_regex ]]; then
			screen "$title" "$subtitle" "$invalid_number_message"
			continue
		fi

		result=$(awk "BEGIN { printf \"%.2f\", $result }")

		if awk "BEGIN {exit !($result < $min_size_gib || $result > $max_size_gib)}"; then
			screen "$title" "$subtitle" "$invalid_number_message"
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

get_ram_bytes() {
	awk '/MemTotal/ {print $2 * 1024}' /proc/meminfo
}

get_sector_size_bytes() {
	cat /sys/block/$(basename "$1")/queue/hw_sector_size
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

make_swap() {
	local disk="$1" start_sector="$2" size_sectors="$3"
	local new_part

	sudo umount /dev/$disk* &>/dev/null || true

	sudo parted -s "/dev/$disk" mkpart primary linux-swap "$start_sector"s $(( $start_sector + $size_sectors - 1 ))s
	new_part=$(lsblk -nrpo NAME,TYPE "/dev/$disk" | awk '$2=="part" {print $1}' | tail -n1)

	sudo swapoff $new_part &>/dev/null || true
	sudo wipefs -a $new_part &>/dev/null || true
	sudo mkswap "$new_part"
	sudo swapon "$new_part"
}

partition_disk() {
	local disk=$1 start_sector=$2 size=$3 encryption_password="$4"
	local sector_size boot_size_sectors
	local efi_part_num root_part_num

	sector_size=$(get_sector_size_bytes $disk)

	boot_size_sectors=$(gib_to_sectors "0.5" $sector_size)
	efi_part_num=$(sudo parted -m "/dev/$disk" print | awk -F: 'END {print $1+1}')
	sudo parted -s "/dev/$disk" mkpart primary fat32 "$start_sector"s $(( $start_sector + $boot_size_sectors - 1 ))s
	sudo parted -s "/dev/$disk" set $efi_part_num esp on
	sudo parted -s "/dev/$disk" set $efi_part_num boot on

	root_part_num=$(sudo parted -m "/dev/$disk" print | awk -F: 'END {print $1+1}')
	size=$(( $size - $boot_size_sectors ))
	start_sector=$(( $start_sector + $boot_size_sectors ))
	sudo parted -s "/dev/$disk" mkpart primary ext4 "$start_sector"s $(( $start_sector + $size - 1 ))s

	exit

	# local efi_part="/dev/$disk$efi_part_num"
	# local root_part="/dev/$disk$root_part_num"

	# mkfs.vfat -n EFI "$efi_part"
	# echo -n "$encryption_password" | sudo cryptsetup luksFormat --type luks2 "$root_part"
	# echo -n "$encryption_password" | sudo cryptsetup open "$root_part" cryptroot
	# mkfs.ext4 -L nixos /dev/mapper/cryptroot

	# mount /dev/mapper/cryptroot /mnt
	# mkdir -p /mnt/boot
	# mount "$efi_part" /mnt/boot
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
			exit
			;;
		"Exit")
			clear
			exit
			;;
	esac
}

setup_internet_screen() {
	local option
	local title="Setup internet connection"
	local subtitle="The installer requires internet connection to so you need to set it up."

	screen "$title" "$subtitle"

	option=$(gum_wrapper choose "Continue" "Back")
	case "$option" in
		"Continue")
			nmtui
			while ! gum spin --spinner meter --title "Checking internet connection..." -- ping -c 4 -W 10 github.com; do
				screen "$title" "" "Could not get response form github.com."

				option=$(gum_wrapper choose "Retry" "Back")
				case "$option" in
					"Retry")
						screen "$title" "$subtitle"
						;;
					"Back")
						screen "$title" "$subtitle"
						nmtui
					;;
				esac
			done
			setup_disk_screen
			exit
			;;
		"Back")
			welcome_screen
			exit
			;;
	esac
}

setup_disk_screen() {
	local title="Setup disk" subtitle="Select a disk to unallocate space for AetherOS and then continue."
	local disks disk option

	screen "$title" "$subtitle"

	disks=$(lsblk -ndAo NAME,SIZE,MODEL)

	option=$(echo -e "$disks\n${GUM_SEPARATOR}\nContinue\nBack" | gum_wrapper choose --header "Choose a disk:")
	case "$option" in
		"Continue")
			setup_swap_screen
			exit
		;;
		"Back")
			setup_internet_screen
			exit
		;;
		*)
			disk=$(echo $option | awk '{print $1;}')
			disk="/dev/$disk"
			sudo cfdisk $disk
			setup_disk_screen
			exit
		;;
	esac
}

setup_swap_screen() {
	local title="Setup swap" option

	if swapon --show | grep -q '^'; then
		screen "$title" "You already have a swap space enabled. Set up swap anyways?"
	else
		screen "$title" "You don't have a swap space enabled. Do you want to create a swap disk?"
	fi

	option=$(gum_wrapper choose "Yes" "No" "Back" )
	case "$option" in
		"Yes")
			allocate_swap_space_screen
			exit
		;;
		"No")
			allocate_space_screen
			exit
		;;
		"Back")
			setup_disk_screen
			exit
		;;
	esac
}

allocate_swap_space_screen() {
	local min_swap_size_gib=1

	local title="Setup swap"
	local option
	local disk start_sector chosen_size_sectors=0

	while [[ $chosen_size_sectors == "0" ]]; do
		screen "$title" "Choose unallocated space to create your swap disk."

		option=$(choose_unallocated_space)
		disk=$(echo "$option" | awk -F',' '{print $1}')
		case "$disk" in
			"Back")
				setup_swap_screen
				exit
			;;
		esac

		local sector_count sector_size_bytes ram_bytes ram_sectors min_swap

		start_sector=$(echo "$option" | awk -F',' '{print $2}')
		sector_count=$(echo "$option" | awk -F',' '{print $4}')

		sector_size_bytes=$(get_sector_size_bytes "$disk")

		ram_bytes=$(get_ram_bytes)
		ram_sectors=$(( ($sector_size_bytes + $ram_bytes - 1) / $sector_size_bytes ))

		min_swap=$(awk "BEGIN {print $min_swap_size_gib * 1024 * 1024 * 1024 / $sector_size_bytes}")
		min_swap=$(ceil $min_swap)

		chosen_size_sectors=$(choose_allocation_size $min_swap $ram_sectors $sector_count $sector_size_bytes "$title")
	done

	local error
	if ! error=$(make_swap $disk $start_sector $chosen_size_sectors); then
		screen "$title" "" "Failed to create swap."
		echo -e "$error"

		option=$(gum_wrapper choose "Back" )
		setup_swap_screen
		exit
	fi

	allocate_space_screen
	exit
}

allocate_space_screen() {
	local min_part_size_gib=1

	local title="Allocate space"
	local disk start_sector chosen_size_sectors=0

	while [[ $chosen_size_sectors == "0" ]]; do
		screen "$title" "Choose unallocated space for AetherOS."

		option=$(choose_unallocated_space)
		disk=$(echo "$option" | awk -F',' '{print $1}')
		case "$disk" in
			"Back")
				setup_swap_screen
				exit
			;;
		esac

		local sector_count sector_size_bytes min_size_sectors

		start_sector=$(echo "$option" | awk -F',' '{print $2}')
		sector_count=$(echo "$option" | awk -F',' '{print $4}')

		sector_size_bytes=$(get_sector_size_bytes "$disk")

		min_size_sectors=$(awk "BEGIN {print $min_part_size_gib * 1024 * 1024 * 1024 / $sector_size_bytes}")
		min_size_sectors=$(ceil $min_size_sectors)

		chosen_size_sectors=$(choose_allocation_size $min_size_sectors $sector_count $sector_count $sector_size_bytes "$title")
	done

	local encryption_password
	encryption_password=$(choose_password "$title" "Choose a password for disk encryption.")
	if [[ -z "$encryption_password" ]]; then
		allocate_space_screen
		exit
	fi

	local error
	if ! error=$(partition_disk $disk $start_sector $chosen_size_sectors $encryption_password); then
		screen "$title" "" "Failed to partition disk."
		echo -e "$error"

		option=$(gum_wrapper choose "Back" )
		allocate_space_screen
		exit
	fi
}






# ================================
# Main
# ================================

allocate_space_screen
#allocate_space
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



# Prompt for hostname, username, password (password will be used for LUKS too)
HOSTNAME=$(dlg_input "Hostname" "Enter the hostname for the installed system:")
USERNAME=$(dlg_input "Username" "Enter the username to create:")


# Wipe and partition the disk: EFI (1) + LUKS root (2)
clear
echo "Wiping $DISK..."
wipefs -a "$DISK" || true

# Create GPT with parted (very basic)
parted --script "$DISK" mklabel gpt
parted --script "$DISK" mkpart primary fat32 1MiB 512MiB
parted --script "$DISK" set 1 esp on
parted --script "$DISK" mkpart primary ext4 512MiB 100%

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
