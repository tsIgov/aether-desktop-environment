#! /bin/sh

UNIT="aether-inhibit.service"
if systemctl --user --quiet is-active "$UNIT"; then
    echo "On"
else
    echo "Off"
fi
