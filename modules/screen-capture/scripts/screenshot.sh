#! @bash@
mkdir -p "@outputDir@"

WORKSPACE=$(hyprctl activewindow -j | jq .workspace.id)
if [[ $WORKSPACE == "null" ]]; then
	WORKSPACE=$(hyprctl activeworkspace -j | jq .id)
fi

GEOMETRY=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $WORKSPACE) | \"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])\"" | slurp -c "@selectionBorderColor@" -b "@overlayColor@" -w 1 -o)

grim -g "$GEOMETRY" -t ppm - | satty --filename -

