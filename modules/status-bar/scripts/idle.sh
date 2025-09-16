#! /bin/sh

STATUS=$(sh /etc/aether/power/scripts/inhibition-status.sh)

if [[ $STATUS == "On" ]]; then
# Output JSON that Waybar can parse
	echo "{\"text\": \"\", \"tooltip\": \"Inhibition enabled\" }"
else
	echo ""
fi


