#! @bash@

step=100

minX=$(@hyprctl@ clients -j | @jq@ "[.[] | select (.floating == false and .workspace.id == $(@hyprctl@ activewindow -j | @jq@ .workspace.id))] | min_by(.at[0]) | .at[0]")
x=$(@hyprctl@ activewindow -j | @jq@ ".at[0]")

if [[ $minX -eq $x ]]; then
    master=true
else
    master=false
fi

xOffset=0
yOffset=0

    case $1 in
        "l" )
			if [[ $master -eq true ]] ; then
				xOffset=-1
			else
				xOffset=1
			fi
		;;
        "r" )
			if [[ $master -eq true ]] ; then
				xOffset=1
			else
				xOffset=-1
			fi
        ;;
        "u" )
           yOffset=-1;;
        "d" )
           yOffset=1;;
   esac

xOffset=$(( $xOffset * $step ))
yOffset=$(( $yOffset * $step ))


@hyprctl@ dispatch resizeactive $xOffset $yOffset
