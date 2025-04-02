{
	system = { pkgs, lib, config, ... }:
	let
		enabled = config.aether.hardware.laptop;
		laptop-lid-action = (pkgs.writeShellScriptBin "laptop-lid-action" ''

				INTEGRATED_MONITOR=`${pkgs.hyprland}/bin/hyprctl monitors all | grep "(ID 0)" | cut -d' ' -f2`
				MONITORS_COUNT=`hyprctl monitors | grep -c "Monitor "`

				if [ $MONITORS_COUNT -eq 0 ]; then
					STATE=open
				elif [ "$#" -eq 1 ]; then
					STATE=$1
				elif [ ! -f /proc/acpi/button/lid/*/state ]; then
					exit 0
				else
					STATE=`cat /proc/acpi/button/lid/*/state | cut -d: -f2 | xargs`
				fi

				if [ $STATE = 'closed' ]; then
					echo "Disabling integrated display"
					${pkgs.hyprland}/bin/hyprctl keyword monitor "$INTEGRATED_MONITOR, disable"
				fi

				if [ $STATE = 'open' ]; then
					echo "Enabling integrated display"
					${pkgs.hyprland}/bin/hyprctl reload
				fi
			'');
	in
	{
		environment.systemPackages = with pkgs; lib.mkIf enabled [
			brightnessctl
			laptop-lid-action
		];

		services = lib.mkIf enabled {
			upower.enable = true;
			power-profiles-daemon.enable = true;
		};

	};
}
