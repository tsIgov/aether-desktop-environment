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

SITE_TO_PING="github.com"

if ! ping -c 4 -W 10 "$SITE_TO_PING" &>/dev/null; then
	echo "Could not get response form $SITE_TO_PING."
	exit 1
fi
