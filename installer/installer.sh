#!/bin/sh
set -euo pipefail

RED='\033[0;31m'
VIOLET='\033[0;35m'
RESET_COLOR='\033[0m'



check_internet() {
	internet=false;
	while [[ $internet == false ]];
	do
		clear
		echo -e "${VIOLET}<<< Setup internet >>>${RESET_COLOR}"
		gum spin --spinner meter --title "Checking internet connection..." -- ping -c 4 -W 10 github.com
		if [[ $? -eq 0 ]]; then
			internet=true;
		else
			echo -e "${RED}Could not get response form github.com.${RESET_COLOR}"
			echo -en "Press any key to configure your WiFi connection..."
			read -rsn1
			impala
		fi
	done
	unset internet
}

partitioning() {
	clear
	echo -e "${VIOLET}<<< Setup disk >>>${RESET_COLOR}"
	disk=$(lsblk -ndAo NAME,SIZE,MODEL | gum choose --header "Choose a disk:")
	disk=$(echo $disk | awk '{print $1;}')
	disk="/dev/$disk"
	sudo cfdisk $disk


	RESULT=$(echo -e "Device,Start sector,End sector,Number of sectors,Size MB,Size GB")
	DEVICES=$(lsblk -ndAo NAME)
	for DEVICE in $DEVICES; do
		SECTOR_SIZE=$(cat /sys/block/$(basename "$DEVICE")/queue/hw_sector_size)
		PARTS=$(sudo parted -m "/dev/$DEVICE" unit s print free | awk -F: -v ss="$SECTOR_SIZE" -v dv="$DEVICE" '
			$1 ~ /^[0-9]+$/ && $5 == "free;" {
				start = substr($2, 1, length($2)-1)
				end   = substr($3, 1, length($3)-1)
				num   = substr($4, 1, length($4)-1)
				size_bytes = num * ss
				size_mb = size_bytes / 1024 / 1024
				size_gb = size_bytes / 1024 / 1024 / 1024
				printf "%s,%d,%d,%d,%.2f MB,%.3f\n", dv, start, end, num, size_mb, size_gb
			}')
		RESULT="$RESULT\n$PARTS"
	done
	echo -e "$RESULT" | gum table -r 1
}

main() {
	check_internet
	partitioning
}

main


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
