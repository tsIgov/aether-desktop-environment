#! /bin/sh

STATUS=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
systemd-ac-power
ON_AC=$?

if [[ $ON_AC -eq 0 && $STATUS == "performance" ]]; then
	echo ""
	exit 0
fi

if [[ $ON_AC -ne 0 && $STATUS == "powersave" ]]; then
	echo ""
	exit 0
fi

echo "{\"text\": \"\", \"class\": \"$STATUS\", \"alt\": \"$STATUS\"}"
