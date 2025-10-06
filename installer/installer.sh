#!/bin/sh
set -euo pipefail

# helper to run dialog and capture output
dlg_input() {
  local title="$1"; shift
  local prompt="$1"; shift
  dialog --backtitle "NixOS custom installer" --title "$title" --inputbox "$prompt" 8 60 2> /tmp/.dlg && cat /tmp/.dlg
}

dlg_password() {
  local title="$1"; shift
  local prompt="$1"; shift
  dialog --backtitle "NixOS custom installer" --title "$title" --passwordbox "$prompt" 8 60 2> /tmp/.dlg && cat /tmp/.dlg
}

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
