#! @bash@

activeWorkspace=$(@hyprctl@ activeworkspace -j | @jq@ ".id")
currentWorkspace=$(@hyprctl@ activewindow -j | @jq@ -r ".workspace.name")
currentMonitor=$(@hyprctl@ activewindow -j | @jq@ -r ".monitor")

if [[ $activeWorkspace -ne $1 ]]; then
	if [[ $currentWorkspace == *"quick"* ]]; then
		quickId=$(echo $currentWorkspace | awk -F '-' '{print $2}')
		destMonitor=$(@hyprctl@ workspaces -j | @jq@ ".[] | select (.id == $1) | .monitorID")

		if [[ $currentMonitor -eq $destMonitor ]]; then
			@hyprctl@ dispatch togglespecialworkspace quick-$quickId
		fi
	fi

	@hyprctl@ dispatch workspace $1
fi

