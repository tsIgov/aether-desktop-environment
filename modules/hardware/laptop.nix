{
	system = { pkgs, lib, config, ... }:
	let
		enabled = config.aether.hardware.laptop;
	in
	{
		environment.systemPackages = with pkgs; lib.mkIf enabled [
			brightnessctl
		];

		services = lib.mkIf enabled {
			upower.enable = true;
			power-profiles-daemon.enable = true;
		};
	};
	home = { pkgs, ... }:
	{
		home.packages = with pkgs; [
			(writeShellScriptBin "laptop-lid-action" ''
				if [ ! -f /proc/acpi/button/lid/*/state ]; then
					exit 0
				fi

				MONITOR=`hyprctl monitors all | grep "(ID 0)" | cut -d' ' -f2`
				STATE=`cat /proc/acpi/button/lid/*/state | cut -d: -f2 | xargs`

				if [ $STATE = 'closed' ]; then
					echo "Disabling integrated display"
					hyprctl keyword monitor "$MONITOR, disable"
				fi

				if [ $STATE = 'open' ]; then
					echo "Enabling integrated display"
					hyprctl reload
				fi
			'')
		];
	};
}
