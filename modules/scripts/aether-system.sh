#!/bin/sh

# ================================
# Help
# ================================
handle_help_arg() {
	if [ $# -eq 0 ]; then
		show_help
		exit 0
	fi

	if [[ " $@ " =~ " -h " || " $@ " =~ " --help " ]]; then
		show_help $1
		exit 0
	fi
}

show_help() {
	if [[ $# -eq 0 ]]; then
    	echo "Usage: $0 [COMMAND]"
		echo 
		echo "Commands:"
		echo -e "apply \t\t Applies the current system configuration."
		echo -e "update \t\t Updates the system."
		echo -e "clean \t\t Removes old generations and cleans the Nix store."
		echo -e "rollback \t Rolls back to a previous generation."
		echo
		echo "For more information about a specific command use: $0 COMMAND --help"
		exit 0
	fi

	case $1 in
		apply)
			echo "Applies the current system configuration."
			echo "Usage: $0 $1 [ARG]"
			echo
			echo "Arguments:"
			echo -e "-h | --help \t Shows this help message."
			exit 0;
		;;
		update)
			echo "Updates the system."
			echo "Usage: $0 $1 [ARG] [INPUTS]"
			echo "Not specifying [INPUTS] will return a list of possible inputs to update."
			echo 
			echo "Arguments:"
			echo -e "-h | --help \t Shows this help message."
			exit 0;
		;;
		clean)
			echo "Removes non-active generations and optimizes the Nix store."
			echo "Usage: $0 $1 [ARGS]"
			echo
			echo "Arguments:"
			echo -e "-d | --days DAYS \t Specifies the number of days since a generation is created for it to be deleted." 
			echo -e "-h | --help \t\t Shows this help message."
			exit 0;
		;;
		rollback)
			echo "Rolls back to a previous generation."
			echo "Usage: $0 $1 [ARGS] [GENERATION]"
			echo "If no generation is specified, will list the available generations instead."
			echo
			echo "Arguments:"
			echo -e "-h | --help \t Shows this help message."
		;;
		*)
			echo "Invalid command. For more information use $0 --help"
			exit 1
		;;
	esac

}




# ================================
# Apply
# ================================
apply() {
	for arg in $@; do
		case $arg in
			*)
				echo "Invalid argument $arg"
			;;
		esac
	done

	echo "Applying system configuration..."
	sudo nixos-generate-config
	sudo nixos-rebuild switch --flake $FLAKE_DIR --impure
	echo "System configuration applied."
}




# ================================
# Update
# ================================
update() {
	if [ $# -eq 0 ]; then
		nix flake metadata $FLAKE_DIR --impure --json | jq -r '.locks.nodes.root.inputs | keys[]' | grep -Ev '^(home-manager)$'
		exit 0;
	fi

	nix flake update $@ --flake $FLAKE_DIR --impure
	apply
}





# ================================
# Clean
# ================================
clean(){
	CLEAN_DAYS=0;
	NEXT_INPUT=""

	for arg in $@; do
		case $arg in
			-d|--days)
				NEXT_INPUT="days"
				;;
			*)
				if [[ $NEXT_INPUT == "" ]]; then
					echo "Invalid argument $arg"
					exit 1
				fi

				case $NEXT_INPUT in
					days)
						if [[ ! $arg =~ ^[0-9]+$ ]]; then
							echo Invalid number of days: $arg
							exit 1
						fi
						CLEAN_DAYS=$arg
						NEXT_INPUT=""
						;;
				esac
			;;
		esac
	done


	if [[ $CLEAN_DAYS -ne 0 ]]; then
		sudo nix-collect-garbage --delete-older-than ${CLEAN_DAYS}d
	else
		sudo nix-collect-garbage -d
	fi

	sudo nix-store --optimise
}




# ================================
# Rollback
# ================================
rollback() {
	GENERATION=0

	for arg in $@; do
		case $arg in
			*)
				if [[ ! $arg =~ ^[0-9]+$ ]]; then
					echo Invalid argument: $arg
					exit 1
				elif [[ $GENERATION -ne 0 ]]; then
					echo Only one generation can be chosen
					exit 1
				fi

				GENERATION=$arg
			;;
		esac
	done

	if [[ $GENERATION -eq 0 ]]; then
		sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
	else
		sudo nix-env --switch-generation $GENERATION
	fi
}




# ================================
# Main
# ================================
set -e

handle_help_arg $@

FLAKE_DIR=$(realpath /etc/aether/)

case $1 in
	apply)
        apply ${@:2}
        ;;
	update)
		update ${@:2}
	;;
	clean)
		clean ${@:2}
	;;
	rollback)
		rollback ${@:2}
	;;
    *)
		echo "Invalid command. For more information use $0 --help"
        exit 1
	;;
esac