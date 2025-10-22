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

disk="$1"
start_s="$2"
size_mib="$3"
sectors_per_mib="$4"

sudo umount /dev/$disk* &>/dev/null || true

sudo parted -s "/dev/$disk" mkpart primary linux-swap "$start_s"s $(( $start_s + $size_mib * $sectors_per_mib - 1 ))s
new_part=$(lsblk -nrpo NAME,TYPE "/dev/$disk" | awk '$2=="part" {print $1}' | tail -n1)

sudo swapoff $new_part &>/dev/null || true
sudo wipefs -af $new_part &>/dev/null || true
sudo mkswap "$new_part"
sudo swapon "$new_part"
