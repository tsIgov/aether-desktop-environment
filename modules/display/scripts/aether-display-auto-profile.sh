handle() {
	case $1 in
		"monitoraddedv2>>"*) ;&
		"monitorremovedv2>>"*)
			monitorId="${1#*>>}"      # Remove everything before >>
			monitorId="${monitorId%%,*}"   # Remove everything after the first ,

			if [[ $monitorId -ne -1 ]]; then
				echo $1
				aether-display-match-profile
			fi
		;;
	esac
}

aether-display-match-profile

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
