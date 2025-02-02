{ config, aether, ... }:
let 
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	wayland.windowManager.hyprland.settings = {
		general = {
			border_size = 2;
			gaps_in = 5;
			gaps_out = 10;
			gaps_workspaces = 0;

			"col.active_border" = "rgb(${palette.accent})";
			"col.inactive_border" = "rgb(${palette.overlay0})";
			"col.nogroup_border" = "rgb(${palette.overlay0})";
			"col.nogroup_border_active" = "rgb(${palette.accent})";
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

		misc = {
			disable_hyprland_logo = true;
			disable_splash_rendering = true;
			force_default_wallpaper = 0;
			background_color = "rgb(${palette.base})";
		};
	};
}

