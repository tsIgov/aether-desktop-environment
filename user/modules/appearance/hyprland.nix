{ config, aetherLib, ... }:
let 
	variant = config.aether.appearance.variant;
  	accent = config.aether.appearance.accent;
	colors = aetherLib.colors.${variant};
in
{
	wayland.windowManager.hyprland.settings = {
		general = {
			border_size = 2;
			gaps_in = 5;
			gaps_out = 10;
			gaps_workspaces = 0;

			"col.active_border" = "rgb(${colors.${accent}})";
			"col.inactive_border" = "rgb(${colors.overlay0})";
			"col.nogroup_border" = "rgb(${colors.overlay0})";
			"col.nogroup_border_active" = "rgb(${colors.${accent}})";
		};

		decoration = {
			rounding = 10;
			#drop_shadow = false;
			blur = {
				enabled = false;
			};
		};

		animations = {
			enabled = true;
			first_launch_animation = false;
			bezier = [
				"myBezier, 0.05, 0.9, 0.1, 1.05"
			];
			animation = [ 
				"windows, 1, 7, myBezier"
				"windowsOut, 1, 7, default, popin 80%"
				"border, 1, 10, default"
				"borderangle, 1, 8, default"
				"fade, 1, 7, default"
				"workspaces, 1, 6, default"
			];
		};

		group = {
			"col.border_active" = "rgb(${colors.${accent}})";
			"col.border_inactive" = "rgb(${colors.overlay0})";
			"col.border_locked_active" = "rgb(${colors.${accent}})";
			"col.border_locked_inactive" = "rgb(${colors.overlay0})";

			groupbar = {
				gradients = false;
				font_size = 10;
				stacked = false;

				"col.active" = "rgba(00000000)";
				"col.inactive" = "rgba(00000000)"; 
				"col.locked_active" = "rgba(00000000)";
				"col.locked_inactive" = "rgba(00000000)"; 
			};
		};

		misc = {
			disable_hyprland_logo = true;
			disable_splash_rendering = true;
			force_default_wallpaper = 0;
			background_color = "rgb(${colors.base})";
		};
	};
}

