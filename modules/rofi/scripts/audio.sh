#!/bin/sh

set -euo pipefail
rofiCmd=(rofi -dmenu -i -no-show-icons -theme-str 'window { location: north; anchor: north; width: 400px; }')

function usage {
    echo "Usage:"
    echo

    echo "To change the default output (e.g., speaker):"
    echo "\$ $0 sink"

    echo

    echo "To change the default input (e.g., microphone):"
    echo "\$ $0 source"
}

function read_arguments {
    if [[ ! $# -eq 1 ]]; then
        usage >&2
        exit 1
    fi

    local type="$1"

    if [[ ! "$type" =~ (sink|source) ]]; then
        usage >&2
        exit 1
    fi

    echo "$type"
}

function formatlist {
   awk 'NR % 3 == 1 {s=substr($2, 1, length($2)-1);} NR % 3 == 2 { gsub(/^[ \t]+|[ \t]+$/, ""); print $0 " (" s ")" }'
}

function select_target {
    local list
    local default
    local default_row

    local type=$1

    list=$(ponymix -t "$type" list | formatlist | grep -v "^Monitor of" || true)
    default=$(ponymix defaults | formatlist)

    # line number of default in list (note: row starts at 0)
    default_row=$(echo "$list" | (grep -nr "$default" - || true) | cut -f1 -d: | awk '{print $0-1}')

	if [ "$type" == "sink" ]; then
		prompt="speaker"
	elif [ "$type" == "source" ]; then
		prompt="microphone"
	else
		prompt=""
	fi

    echo "$list" \
        | "${rofiCmd[@]}" -p "$prompt" -selected-row "$default_row" \
        | grep -oP '\(\K\d+(?=\))'
}

function set_default {
    local type="$1"
    local device="$2"
    ponymix set-default -t "$type" -d "$device"
}

function move_all_streams {
    local type=$1

    case "$type" in
        sink)
            for input in $(ponymix list -t sink-input|grep -Po '[0-9]+(?=:)'); do
                         ponymix -t sink-input -d "$input" move "$device"
            done
            ;;

        source)
            for output in $(ponymix list -t source-output | grep -Po '[0-9]+(?=:)'); do
                ponymix -t source-output -d "$output" move "$device"
            done
            ;;
    esac
}

function main {
    local type
    local device

    type=$(read_arguments "$@")
    device=$(select_target "$type")

    set_default "$type" "$device"

    move_all_streams "$type"
}
main "$@"
