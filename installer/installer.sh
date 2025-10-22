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

	csv="$csv\n$GUM_SEPARATOR,,,\nBack,,,"

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

gum_spin() {
	gum spin --spinner meter --title "$1" -- $2
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


make_swap() {
	local disk="$1" start_s="$2" size_mib="$3" sectors_per_mib="$4"
	local new_part

	sudo umount /dev/$disk* &>/dev/null || true

	sudo parted -s "/dev/$disk" mkpart primary linux-swap "$start_s"s $(( $start_s + $size_mib * $sectors_per_mib - 1 ))s
	new_part=$(lsblk -nrpo NAME,TYPE "/dev/$disk" | awk '$2=="part" {print $1}' | tail -n1)

	sudo swapoff $new_part &>/dev/null || true
	sudo wipefs -af $new_part &>/dev/null || true
	sudo mkswap "$new_part"
	sudo swapon "$new_part"
}

partition_disk() {
	local disk=$1 start_s=$2 size_mib=$3 sectors_per_mib=$4 encryption_password="$5"
	local boot_size_mib=512
	local efi_part_num root_part_num

	efi_part_num=$(sudo parted -m "/dev/$disk" print | awk -F: 'END {print $1+1}')
	root_part_num=$(( $efi_part_num + 1 ))
	local efi_part="/dev/$disk$efi_part_num"
	local root_part="/dev/$disk$root_part_num"

	sudo parted -s "/dev/$disk" mkpart primary fat32 "$start_s"s $(( $start_s + $boot_size_mib * $sectors_per_mib - 1 ))s
	sudo wipefs -fa "$efi_part"
	sudo parted -s "/dev/$disk" set $efi_part_num esp on
	sudo parted -s "/dev/$disk" set $efi_part_num boot on

	size_mib=$(( $size_mib - $boot_size_mib ))
	start_s=$(( $start_s + $boot_size_mib * $sectors_per_mib ))

	sudo parted -s "/dev/$disk" mkpart primary ext4 "$start_s"s $(( $start_s + $size_mib * $sectors_per_mib - 1 ))s
	sudo wipefs -fa "$root_part"

	sudo umount "/dev/$disk*" &>/dev/null || true

	exit


	# sudo mkfs.vfat -n EFI "$efi_part"

	# sudo cryptsetup close luks-2df5bf24-b44b-40b8-891d-7387d801e1e4
	# systemctl --user stop udiskie.service
	# echo -n "$encryption_password" | sudo cryptsetup luksFormat --type luks2 "$root_part"
	# echo -n "$encryption_password" | sudo cryptsetup open "$root_part" cryptroot
	# sudo mkfs.ext4 -L nixos /dev/mapper/cryptroot

	# sudo mkdir -p /mnt
	# sudo mount /dev/mapper/cryptroot /mnt
	# sudo mkdir -p /mnt/boot
	# sudo mount "$efi_part" /mnt/boot
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

	screen "$title" ""

	if gum_spin "Checking internet connection..." "ping -c 4 -W 10 github.com"; then
		setup_disk_screen
	else
		screen "$title" "" "Could not get response form github.com."

		option=$(gum_wrapper choose "Retry" "Configure")
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
		esac
	fi

	option=$(gum_wrapper choose "Continue" "Back")
	case "$option" in
		"Continue")
			nmtui
			while ! gum_spin "Checking internet connection..." "ping -c 4 -W 10 github.com"; do
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
			welcome_screen
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
	local min_swap_mib=1024

	local title="Setup swap"
	local option
	local disk start_s chosen_size_mib=0

	while [[ $chosen_size_mib == "0" ]]; do
		screen "$title" "Choose unallocated space to create your swap disk."

		option=$(choose_unallocated_space)
		disk=$(echo "$option" | awk -F',' '{print $1}')
		case "$disk" in
			"Back")
				setup_swap_screen
				exit
			;;
		esac

		local size_mib ram_mib sectors_per_mib
		sectors_per_mib=$(get_sectors_per_mib $disk)

		start_s=$(echo "$option" | awk -F',' '{print $2}')
		size_mib=$(echo "$option" | awk -F',' '{print $4}')

		ram_mib=$(get_ram_mib)

		chosen_size_mib=$(choose_allocation_size $min_swap_mib $ram_mib $size_mib "$title")
	done

	local error
	if ! error=$(make_swap $disk $start_s $chosen_size_mib $sectors_per_mib); then
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
	local min_size_mib=1024

	local title="Allocate space"
	local disk start_s chosen_size_mib=0

	while [[ $chosen_size_mib == "0" ]]; do
		screen "$title" "Choose unallocated space for AetherOS."

		option=$(choose_unallocated_space)
		disk=$(echo "$option" | awk -F',' '{print $1}')
		case "$disk" in
			"Back")
				setup_swap_screen
				exit
			;;
		esac

		local size_mib sectors_per_mib
		sectors_per_mib=$(get_sectors_per_mib $disk)

		start_s=$(echo "$option" | awk -F',' '{print $2}')
		size_mib=$(echo "$option" | awk -F',' '{print $4}')

		chosen_size_mib=$(choose_allocation_size $min_size_mib $size_mib $size_mib "$title")
	done

	local encryption_password
	encryption_password=$(choose_password "$title" "Choose a password for disk encryption.")
	if [[ -z "$encryption_password" ]]; then
		allocate_space_screen
		exit
	fi

	local error
	if ! error=$(partition_disk $disk $start_s $chosen_size_mib $sectors_per_mib $encryption_password); then
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

#welcome_screen
#allocate_swap_space_screen
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
mkdir -p /mnt/boot
mount /dev/mapper/cryptroot /mnt
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
