#! /bin/sh

OutputDir="$HOME/Pictures/Screenshots"
mkdir -p "$OutputDir"

pkill slurp || hyprshot -m ${1:-region} --raw |
satty --filename - \
	--output-filename "$OutputDir/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
	--early-exit \
	--actions-on-enter save-to-clipboard \
	--disable-notifications \
	--copy-command 'wl-copy'

