#!/bin/bash

# Get disk usage percentage as an integer
values=$(free --mega | grep "Mem:")
total=$(echo $values | awk '{print $2}') 
used=$(echo $values | awk '{print $3}') 
avail=$(echo $values | awk '{print $7}') 
percentage=$(( used * 100 / total ))

total=$(echo $total | rev | cut -c3- | rev | awk '{print substr($0, 1, length($0)-1) "." substr($0, length($0))}')
used=$(echo $used | rev | cut -c3- | rev | awk '{print substr($0, 1, length($0)-1) "." substr($0, length($0))}')
avail=$(echo $avail | rev | cut -c3- | rev | awk '{print substr($0, 1, length($0)-1) "." substr($0, length($0))}')

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


