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

nixos-generate-config --root /mnt # TODO copy the hardware config file
