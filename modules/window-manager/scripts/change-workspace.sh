#! @bash@

MAIN_WORKSPACE=$(@hyprctl@ activeworkspace -j | @jq@ -r ".id")
CURRENT_WORKSPACE=$(@hyprctl@ activewindow -j | @jq@ -r ".workspace.name")
CURRENT_MONITOR=$(@hyprctl@ activewindow -j | @jq@ -r ".monitor")

if [[ $MAIN_WORKSPACE -eq $1 ]]; then
	exit 0
fi

if [[ $CURRENT_WORKSPACE == *"quick"* ]]; then
	QUICK_WORKSPACE_ID=$(echo $CURRENT_WORKSPACE | awk -F '-' '{print $2}')
	DEST_MONITOR=$(@hyprctl@ workspaces -j | @jq@ ".[] | select (.id == $1) | .monitorID")

	if [[ $CURRENT_MONITOR -eq $DEST_MONITOR ]]; then
		@hyprctl@ dispatch togglespecialworkspace quick-$QUICK_WORKSPACE_ID
	fi
fi

@hyprctl@ dispatch workspace $1

