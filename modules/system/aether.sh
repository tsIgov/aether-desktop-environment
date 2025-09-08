#! /bin/sh
set -euo pipefail
config_location="/etc/aether-os"



show_help() {
    cat << EOF
Usage: $0 [COMMAND] [ARGS...]

Commands:
  apply 		       Applies the current configuration
  update [ARGS...]     Updates AetherOS and applies the current configuration.

Arguments for update:
  all                  Also updates all other inputs
  [input1 input2 ...]  Also updates the specified inputs

Options:
  -h, --help      Show this help message
EOF
}



update() {
	sudo -v

	if [[ $# -eq 0 ]]; then
		inputs="aether"
	elif [[ "$1" == "all" ]]; then
		inputs=""
	else
		inputs=("$@")
	fi

	cd "$config_location"
	nix flake update "${inputs[@]}"
	sudo nixos-rebuild switch --flake .#aether-os
}



apply() {
	sudo -v

	cd "$config_location"
	sudo nixos-rebuild switch --flake .#aether-os
}



if [[ $# -eq 0 ]]; then
    show_help
    exit 0
fi

case "$1" in
    -h|--help)
        show_help
        ;;
    update)
        shift
        update "$@"
        ;;
    apply)
        shift
        apply "$@"
        ;;
    *)
        echo "Error: Unknown command '$1'"
        show_help
        exit 1
        ;;
esac

