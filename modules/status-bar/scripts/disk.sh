#! @bash@

# Get disk usage percentage as an integer
values=$(df --output=used,avail,pcent --block-size=G / | tail -1 | tr -d G%)
used=$(echo $values | cut -f1 -d ' ')
avail=$(echo $values | cut -f2 -d ' ')
percentage=$(echo $values | cut -f3 -d ' ')
avail_percentage=$((100 - percentage))
total=$((used + avail))


# Define text, tooltip and class based on percentage
tooltip="Disk\nUsed:  ${used} GB (${percentage}%)\nAvail: ${avail} GB (${avail_percentage}%)\nTotal: ${total} GB"

# Set class based on usage thresholds
if [ "$percentage" -ge 90 ]; then
	class="critical"
elif [ "$percentage" -ge 75 ]; then
	class="warning"
else
	class="normal"
fi

# Output JSON that Waybar can parse
echo "{\"text\": \"\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"percentage\": $percentage }"


