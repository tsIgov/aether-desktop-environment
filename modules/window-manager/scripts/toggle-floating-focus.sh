#! @bash@

IS_FLOATING=$(@hyprctl@ activewindow -j | @jq@ -r '.floating')

if [ "$IS_FLOATING" == "true" ]; then
    @hyprctl@ dispatch focuswindow tiled
else
    @hyprctl@ dispatch focuswindow floating
fi
