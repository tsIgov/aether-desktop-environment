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

sed_escape() {
	local v="$1"
	v=${v//\\/\\\\}
	v="${v//&/\\&}"
	v="${v//\//\\/}"
	echo "$v"
}

hostname="$1"
root_password=$(mkpasswd "$2")
root_password=$(sed_escape "$root_password")

username="$3"
user_password=$(mkpasswd "$4")
user_password=$(sed_escape "$user_password")


swap_size="$5"

root_dir="/mnt/etc/aether-os"

sudo mkdir -p "$root_dir"
sudo nix flake new --refresh -t github:tsIgov/aether-os#installer "$root_dir"


sudo sed -i "s/{HOSTNAME}/$hostname/g" "$root_dir/config/connectivity.nix"
sudo sed -i "s/{USERNAME}/$username/g" "$root_dir/config/user.nix"

sudo sed -i "s/{USERNAME}/$username/g" "$root_dir/modules/initial-passwords.nix"
sudo sed -i "s/{USER_PASSWORD}/$user_password/g" "$root_dir/modules/initial-passwords.nix"
sudo sed -i "s/{ROOT_PASSWORD}/$root_password/g" "$root_dir/modules/initial-passwords.nix"


if [[ $swap_size -gt 0 ]]; then
	sudo sed -i 's|#||g' "$root_dir/file-system-configuration.nix"
fi

sudo nixos-generate-config --show-hardware-config --no-filesystems | sudo tee "$root_dir/hardware-configuration.nix" > /dev/null
