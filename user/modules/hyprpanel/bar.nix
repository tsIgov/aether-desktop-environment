{ pkgs, ... }:
{
	programs.hyprpanel = {
		layout = {
			"bar.layouts"."*" =  {
				left = [
					"windowtitle"
				];
				middle = [
					"workspaces"
				];
				right = [
					"submap"
					"kbinput"
					"bluetooth"
					"volume"
					"network"
					"battery"
					"clock"
					"systray"
					"notifications"
				];
			};
		};

		settings = {
			bar.autoHide = "fullscreen";

			menus.clock = {
				time.hideSeconds = false;
				time.military = true;
				weather.enabled = false;
			};

			theme.bar = {
				dropdownGap = "3.5rem";
				floating = true;
				label_spacing = "0.5em";
				layer = "overlay";
				location = "top";
				margin_bottom = "0em";
				margin_sides = "0.5em";
				margin_top = "0.5em";
				opacity = 100;
				outer_spacing = "0.4em";
				scaling = 100;
				transparent = false;

				border = {
					location = "full";
					width = "0.1em";
				};
				border_radius = "1rem";

				buttons = {
					background_hover_opacity = 70;
					background_opacity = 0;
					enableBorders = false;
					monochrome = true;
					opacity = 100;
					padding_x = "0.4em";
					padding_y = "0.1rem";
					spacing = "0em";
					y_margins = "0.4em";
				};
			};
		};
	};
}