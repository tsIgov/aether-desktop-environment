#!/bin/bash

export S_TIME_FORMAT=ISO

# cpu
cpu_percentage=$(mpstat | grep -A 1 "%idle" | tail -n 1 | awk -F " " '{print 100 -  $ 12}'a)
cpu_text="CPU:   ${cpu_percentage}%"

# temperature
temps=$(cat /sys/class/thermal/thermal_zone*/temp)
temp_max=0
for temp in $temps; do
    if [[ "$temp" =~ ^[0-9]+$ ]]; then
        if (( temp > max )); then
            temp_max=$temp
        fi
    fi
done
temp_max=$(echo $temp_max | rev | cut -c4- | rev)
temp_text="Temp:  ${temp_max}°C"

# memory
mem_values=$(free --mega | grep "Mem:")
mem_total=$(echo $mem_values | awk '{print $2}')
mem_used=$(echo $mem_values | awk '{print $3}')
mem_avail=$(echo $mem_values | awk '{print $7}')
mem_percentage=$(( mem_used * 100 / mem_total ))
mem_avail_percentage=$(( 100 - mem_percentage ))

mem_total=$(echo $mem_total | rev | cut -c3- | rev | awk '{print substr($0, 1, length($0)-1) "." substr($0, length($0))}')
mem_used=$(echo $mem_used | rev | cut -c3- | rev | awk '{print substr($0, 1, length($0)-1) "." substr($0, length($0))}')
mem_avail=$(echo $mem_avail | rev | cut -c3- | rev | awk '{print substr($0, 1, length($0)-1) "." substr($0, length($0))}')
mem_text="Memory\nUsed:  ${mem_used} GB (${mem_percentage}%)\nAvail: ${mem_avail} GB (${mem_avail_percentage}%)\nTotal: ${mem_total} GB"


tooltip="${cpu_text}\n${temp_text}\n\n${mem_text}"

# Set class based on usage thresholds
if [[ "$cpu_percentage" -ge 80 || "$mem_percentage" -ge 90 || "$temp_max" -ge 90 ]]; then
	class="critical"
elif [[ "$cpu_percentage" -ge 50 || "$mem_percentage" -ge 75 || "$temp_max" -ge 75 ]]; then
	class="warning"
else
	class="normal"
fi

# Output JSON that Waybar can parse
echo "{\"text\": \"\", \"tooltip\": \"$tooltip\", \"class\": \"$class\" }"
