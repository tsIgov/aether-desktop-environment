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

USERNAME="$1"

SOURCE_DIR="/mnt/etc/aether-os"
TARGET_DIR="/mnt/home/${USERNAME}/.config"

sudo rm "$SOURCE_DIR/modules/initial-passwords.nix"

sudo mkdir -p "$TARGET_DIR"
sudo mv "$SOURCE_DIR" "$TARGET_DIR/aether"

cryptsetup close cryptroot || true
