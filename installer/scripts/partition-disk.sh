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

unmnt() {
	local disk=$1
	sudo umount /mnt/boot &>/dev/null || true
	sudo umount /mnt &>/dev/null || true
	sudo rm -rf /mnt &>/dev/null || true
	sudo umount "/dev/$disk*" &>/dev/null || true
}

close_crypt() {
	local disk=$1
	local efi_name="$disk$efi_part_num"
	local root_name="$disk$root_part_num"

	local crypts
	crypts=$(lsblk --fs -J | jq -r ".blockdevices[]
		| select(.name == \"$disk\")
		| .children[]
		| select(.children != null and .fstype == \"crypto_LUKS\")
		| .children[].name")

	for crypt in $crypts; do
		sudo cryptsetup close "$crypt" &>/dev/null || true
	done
}

disk=$1
start_s=$2
total_size_mib=$3
sectors_per_mib=$4
encryption_password="$5"

boot_size_mib=512
boot_start_s=$start_s
boot_end_s=$(( $boot_start_s + $boot_size_mib * $sectors_per_mib - 1 ))

root_size_mib=$(( $total_size_mib - $boot_size_mib ))
root_start_s=$(( $boot_start_s + $boot_size_mib * $sectors_per_mib ))
root_end_s=$(( $root_start_s + $root_size_mib * $sectors_per_mib - 1 ))

efi_part_num=$(sudo parted -m "/dev/$disk" print | awk -F: 'END {print $1+1}')
efi_part="/dev/$disk$efi_part_num"

root_part_num=$(( $efi_part_num + 1 ))
root_part="/dev/$disk$root_part_num"

unmnt $disk
close_crypt $disk
sudo swapoff /dev/$disk* &>/dev/null || true

sudo parted -s "/dev/$disk" mkpart primary fat32 "$boot_start_s"s "$boot_end_s"s
sudo parted -s "/dev/$disk" mkpart primary ext4 "$root_start_s"s "$root_end_s"s

sudo wipefs -fa "$efi_part" &>/dev/null || true
sudo wipefs -fa "$root_part" &>/dev/null || true

sudo parted -s "/dev/$disk" set $efi_part_num esp on
sudo parted -s "/dev/$disk" set $efi_part_num boot on

sudo mkfs.vfat -n EFI "$efi_part"

echo -n "$encryption_password" | sudo cryptsetup luksFormat --type luks2 "$root_part"
echo -n "$encryption_password" | sudo cryptsetup open "$root_part" cryptroot
sudo mkfs.ext4 -L aetheros /dev/mapper/cryptroot

sudo mkdir -p /mnt
sudo mount /dev/mapper/cryptroot /mnt

sudo mkdir -p /mnt/boot
sudo mount "$efi_part" /mnt/boot
