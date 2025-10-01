#! @bash@

STEP=50

ACTIVE_WORKSPACE=$(@hyprctl@ activewindow -j | @jq@ -r .workspace.id)
MIN_X=$(@hyprctl@ clients -j | @jq@ -r "[.[] | select (.floating == false and .workspace.id == $ACTIVE_WORKSPACE)] | min_by(.at[0]) | .at[0]")
ACTIVE_WINDOW_X=$(@hyprctl@ activewindow -j | @jq@ -r ".at[0]")

if [[ $MIN_X -eq $ACTIVE_WINDOW_X ]]; then
    MASTER=true
else
    MASTER=false
fi

X_OFFSET=0
Y_OFFSET=0
case $1 in
	"l" )
		if [[ $MASTER -eq true ]] ; then
			X_OFFSET=-1
		else
			X_OFFSET=1
		fi
	;;
	"r" )
		if [[ $MASTER -eq true ]] ; then
			X_OFFSET=1
		else
			X_OFFSET=-1
		fi
	;;
	"u" )
		Y_OFFSET=-1;;
	"d" )
		Y_OFFSET=1;;
esac

X_OFFSET=$(( $X_OFFSET * $STEP ))
Y_OFFSET=$(( $Y_OFFSET * $STEP ))


@hyprctl@ dispatch resizeactive $X_OFFSET $Y_OFFSET
