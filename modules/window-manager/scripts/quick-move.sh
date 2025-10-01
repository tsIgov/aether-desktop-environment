#! @bash@

WORKSPACE=$(@hyprctl@ activewindow -j | @jq@ -r ".workspace.name")

if [[ $WORKSPACE == *"quick"* ]]; then
	DESTINATION=$(echo $WORKSPACE | @awk@ -F '-' '{print $2}')
else
	DESTINATION="special:quick-${WORKSPACE}"
fi

@hyprctl@ dispatch movetoworkspacesilent $DESTINATION
