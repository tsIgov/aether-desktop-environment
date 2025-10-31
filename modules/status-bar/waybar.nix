{ config, pkgs, ... }:
let
	gtkPalette = config.aether.theme.gtk-color-scheme;
in
{
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

		home.file = {
			".config/waybar/fonts.css".source = pkgs.replaceVars ./fonts.css {
				fontIcons = config.aether.theme.fonts.icons;
				fontMono = config.aether.theme.fonts.mono;
			};
			".config/waybar/colors.css".text = gtkPalette;
		};
	};
}
