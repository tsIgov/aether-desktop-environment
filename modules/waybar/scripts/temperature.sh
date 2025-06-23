#!/bin/bash
temps=$(cat /sys/class/thermal/thermal_zone*/temp)

# Initialize max temp
max=0
# Find the maximum temperature
for temp in $temps; do
    if [[ "$temp" =~ ^[0-9]+$ ]]; then
        if (( temp > max )); then
            max=$temp
        fi
    fi
done

max=$(echo $max | rev | cut -c4- | rev)

percentage=$max;
text="${max}°C"

# Set class based on usage thresholds
if [ "$max" -ge 90 ]; then
	class="critical"
elif [ "$max" -ge 75 ]; then
	class="warning"
else
	class="normal"
fi

# Output JSON that Waybar can parse
echo "{\"text\": \"$text\", \"class\": \"$class\", \"percentage\": $percentage }"


