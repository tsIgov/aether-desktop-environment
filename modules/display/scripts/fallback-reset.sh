#! @bash@
set +u

outputFile="$HOME/.config/hypr/monitors.conf"
enabledMonitors=$(@hyprctl@ -j monitors | @jq@ '[.[] | select(.disabled == false)] | length')

if [[ $enabledMonitors -eq 0 ]]; then
	configValues="monitor = , preferred, auto, auto"
	echo -e "$configValues" > "$outputFile"
fi
