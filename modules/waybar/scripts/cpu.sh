#!/bin/bash

export S_TIME_FORMAT=ISO

# Define text, tooltip and class based on percentage
tooltip=$(mpstat --dec=1 -P ALL | tail -n +4 | awk '{print "CPU: " $2,$3"%\\n"}' | tail -n +1 |   tr -d '\n' | head -c -2 | column -t)
percentage=$(echo $tooltip | cut -f 3 -d " " | cut -f 1 -d ".")
text="${percentage}%"

# Set class based on usage thresholds
if [ "$percentage" -ge 80 ]; then
	class="critical"
elif [ "$percentage" -ge 50 ]; then
	class="warning"
else
	class="normal"
fi

# Output JSON that Waybar can parse
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"percentage\": $percentage }"
