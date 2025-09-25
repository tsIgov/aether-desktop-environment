#! @bash@

handle() {
	case $1 in
		"monitoraddedv2>>"*) ;&
		"monitorremovedv2>>"*)
			monitorId="${1#*>>}"      # Remove everything before >>
			monitorId="${monitorId%%,*}"   # Remove everything after the first ,

			if [[ $monitorId -ne -1 ]]; then
				/etc/aether/display/scripts/apply-profile.sh
			fi
		;;
	esac
}

/etc/aether/display/scripts/apply-profile.sh
/etc/aether/window-manager/scripts/change-workspace.sh 1

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
