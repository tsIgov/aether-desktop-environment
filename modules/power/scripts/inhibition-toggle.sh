#! /bin/sh

UNIT="aether-inhibit.service"

start_inhibit() {
    systemd-run --user --unit="$UNIT" \
		bash -c 'exec systemd-inhibit --what=idle --why="User toggled idle inhibition" sleep infinity'
	notify-send -e -a aether "Idling inhibited"
}

stop_inhibit() {
    systemctl --user stop "$UNIT"
	notify-send -e -a aether "Idling allowed"
}

if systemctl --user --quiet is-active "$UNIT"; then
    stop_inhibit
else
    start_inhibit
fi
