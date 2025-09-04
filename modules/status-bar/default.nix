{
	system = { hostName, ... }:
	{
		environment.etc."aether/status-bar/scripts".source = ./scripts;
	};

	home = { aether, pkgs, ... }:
	{
		programs.waybar = {
			enable = true;
			systemd = {
				enable = true;
				target = "hyprland-session.target";
			};
			settings = {
				mainBar = {
					layer = "top";
					position = "top";
					margin-left = 10;
					margin-right = 10;
					margin-top = 10;
					margin-bottom = 0;
					fixed-center = true;
					reload_style_on_change = true;

					modules-left = [
						"hyprland/window"
					];

					modules-center = [
						"group/central"
					];

					modules-right = [
						"group/keyboard"
						"group/connectivity"
						"group/power"
						"group/system"
						"group/notifications"
					];
				};
			};
			style = ./style.css;
		};
	};
}
