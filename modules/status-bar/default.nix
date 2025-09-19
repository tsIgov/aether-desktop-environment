{ aether, config, ... }:
let
	gtkPalette = aether.lib.appearance.getGtkColorDefinitions { inherit config; };
in
{
	environment.etc."aether/status-bar/scripts".source = ./scripts;

	hm = {
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
						"group/system"
						"group/notifications"
					];
				};
			};
			style = ./style.css;
		};

		home.file.".config/waybar/colors.css".text = gtkPalette;
	};
}
