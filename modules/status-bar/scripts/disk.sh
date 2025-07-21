#!/bin/bash

# Get disk usage percentage as an integer
values=$(df --output=used,avail,pcent --block-size=G / | tail -1 | tr -d G%)
used=$(echo $values | cut -f1 -d ' ')
avail=$(echo $values | cut -f2 -d ' ')
percentage=$(echo $values | cut -f3 -d ' ')
total=$((used + avail))


# Define text, tooltip and class based on percentage
text="${percentage}%"
tooltip="${used}GB (${percentage}%) used out of ${total}GB\n${avail}GB available"

# Set class based on usage thresholds
if [ "$percentage" -ge 90 ]; then
	class="critical"
elif [ "$percentage" -ge 75 ]; then
	class="warning"
else
	class="normal"
fi

# Output JSON that Waybar can parse
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"percentage\": $percentage }"


