all="shutdown reboot suspend hibernate logout lockscreen"
show=("${all[@]}")

declare -A texts
texts[lockscreen]="lock screen"
texts[switchuser]="switch user"
texts[logout]="log out"
texts[suspend]="suspend"
texts[hibernate]="hibernate"
texts[reboot]="reboot"
texts[shutdown]="shut down"

declare -A icons
icons[lockscreen]="firefox"
#icons[lockscreen]="\Uf033e"
icons[switchuser]="\Uf0019"
icons[logout]="\Uf0343"
icons[suspend]="\Uf04b2"
icons[hibernate]="\Uf02ca"
icons[reboot]="\Uf0709"
icons[shutdown]="\Uf0425"
icons[cancel]="\Uf0156"

declare -A actions
#actions[lockscreen]="swaylock"
actions[lockscreen]="hyprshot -m window -s -o /home/igov/"
#actions[switchuser]="???"
actions[logout]="loginctl terminate-session ${XDG_SESSION_ID-}"
actions[suspend]="systemctl suspend"
actions[hibernate]="systemctl hibernate"
actions[reboot]="systemctl reboot"
actions[shutdown]="systemctl poweroff"

execute() {
	for entry in $all
	do
		if [[ "${texts[$entry]}" == "$@" ]]; then
			${actions[$entry]}
			exit 0
		fi
	done
}

render() {
	echo -e "${texts[$1]}\0icon\x1f${icons[$1]}"
}

if [ $# -eq 0 ]
then
	for entry in $all
	do
		render $entry
	done

	echo -e "\0no-custom\x1ftrue"
	exit 0
fi

execute $@