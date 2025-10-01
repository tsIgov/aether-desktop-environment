#! @bash@

WORKSPACE=$(@hyprctl@ activewindow -j | @jq@ -r .workspace.name)
if [[ $WORKSPACE == "null" ]]; then
	WORKSPACE=$(@hyprctl@ activeworkspace -j | @jq@ -r .name)
fi

if [[ "$WORKSPACE" == *"quick"* ]]; then
	SPECIAL_WORKSPACE=$(echo $WORKSPACE | @awk@ -F ':' '{print $2}')
else
	SPECIAL_WORKSPACE="quick-$WORKSPACE"
fi

@hyprctl@ dispatch togglespecialworkspace $SPECIAL_WORKSPACE
