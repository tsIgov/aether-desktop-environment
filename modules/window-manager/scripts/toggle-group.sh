#! @bash@

groupMembers=$(@hyprctl@ activewindow -j | @jq@ '.grouped | length')

if [[ $groupMembers -lt 2 ]]; then
    @hyprctl@ dispatch togglegroup
else
    @hyprctl@ dispatch lockactivegroup toggle
fi
