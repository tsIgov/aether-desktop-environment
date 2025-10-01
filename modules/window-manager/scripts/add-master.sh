#! @bash@

ACTIVE_WORKSPACE=$(@hyprctl@ activewindow -j | @jq@ -r .workspace.id)
MIN_X=$(@hyprctl@ clients -j | @jq@ -r "[.[] | select (.floating == false and .workspace.id == $ACTIVE_WORKSPACE)] | min_by(.at[0]) | .at[0]")

ACTIVE_WINDOW_X=$(@hyprctl@ activewindow -j | @jq@ -r ".at[0]")

if [[ $MIN_X -eq $ACTIVE_WINDOW_X ]]; then # this is a master window.
	@hyprctl@ dispatch layoutmsg removemaster
else
    @hyprctl@ dispatch layoutmsg addmaster
fi

