profiles="$HOME/.config/aether/display-profiles.json"
outputFile="$HOME/.config/hypr/monitors.conf"

getMonitorConfig() {
	name=$1
	enabled=$(echo $2 | jq -r '.enabled')
	resolution=$(echo $2 | jq -r '.resolution')
	position=$(echo $2 | jq -r '.position')
	scale=$(echo $2 | jq -r '.scale')
	extraArgs=$(echo $2 | jq -r '.extraArgs')

	if [[ $enabled == "false" ]]; then
		echo "monitor = $name, disable"
		return 0
	fi

	if [[ $extraArgs != "" ]]; then
		extraArgs=", $extraArgs"
	fi

	echo "monitor = $name, $resolution, $position, $scale$extraArgs"
}

currentMonitors=$(hyprctl monitors all -j | jq -r '.[].name')
currentMonitors=$(echo $currentMonitors) # gets them on a single line
currentMonitorsCount=$(echo $currentMonitors | wc -w)

# Parse each profile
while read -r profile; do
    profileMonitorsCount=$(jq '.monitors | length' <<< "$profile")

	# Can't be matched as the profile has different number of monitors
	if [[ "$currentMonitorsCount" -ne "$profileMonitorsCount" ]]; then
        continue
    fi

	configValues="";

    while read -r monitor; do
		matched=0
        nameRegex=$(jq -r '.name' <<< "$monitor")
        for currentMonitor in $currentMonitors; do
            if [[ $currentMonitor =~ ^$nameRegex$ ]]; then
				matched=1
                matchedMonitors="$matchedMonitors $currentMonitor"
				monitorConfig=$(getMonitorConfig $currentMonitor $monitor)
				configValues="$configValues\n$monitorConfig"
                break
            fi
        done

		if [[ $matched -eq 0 ]]; then
			break
		fi
    done < <(jq -c '.monitors[]' <<< "$profile")
	# One of the rules was not matched.
	if [[ $matched -eq 0 ]]; then
		continue
	fi

	for currentMonitor in $currentMonitors; do
		matched=0
		for matchedMonitor in $matchedMonitors; do
			if [[ "$matchedMonitor" == "$currentMonitor" ]]; then
				matched=1
				break
			fi
		done
		if [[ $matched -eq 0 ]]; then
			break
		fi
	done
	# One of the current monitors was not matched.
	if [[ $matched -eq 0 ]]; then
		continue
	fi

	# The profile matched
	profileMatched="true"
	break

done < <(jq -c '.[]' "$profiles")

if [[ $profileMatched != "true" ]]; then
	configValues="monitor = , preferred, auto, auto"
fi

echo -e "$configValues" > $outputFile
