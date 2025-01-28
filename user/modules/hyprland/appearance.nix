{ config, aether, ... }:
let 
	flavorName = config.aether.appearance.flavor;
  	accent = config.aether.appearance.accent;
	flavor = aether.lib.appearance.flavors.${flavorName};
in
{
	wayland.windowManager.hyprland.settings = {
		general = {
			border_size = 2;
			gaps_in = 5;
			gaps_out = 10;
			gaps_workspaces = 0;

			"col.active_border" = "rgb(${flavor.${accent}})";
			"col.inactive_border" = "rgb(${flavor.overlay0})";
			"col.nogroup_border" = "rgb(${flavor.overlay0})";
			"col.nogroup_border_active" = "rgb(${flavor.${accent}})";
		};

		decoration = {
			rounding = 10;
			blur.enabled = false;
			shadow.enabled = false;
		};

		animations = {
			enabled = true;
			first_launch_animation = false;
			bezier = [
				"myBezier, 0.05, 0.9, 0.1, 1.05"
			];
			animation = [ 
				"windows, 1, 7, myBezier, slide"
				"border, 1, 7, default"
				"fade, 1, 7, myBezier"
				"workspaces, 1, 10, myBezier, fade"
			];
		};

		group = {
			"col.border_active" = "rgb(${flavor.${accent}})";
			"col.border_inactive" = "rgb(${flavor.overlay0})";
			"col.border_locked_active" = "rgb(${flavor.${accent}})";
			"col.border_locked_inactive" = "rgb(${flavor.overlay0})";

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
			background_color = "rgb(${flavor.base})";
		};
	};
}

