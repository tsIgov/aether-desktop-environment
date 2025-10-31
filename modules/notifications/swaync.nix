{ config, ... }:
let
	gtkPalette = config.aether.theme.gtk-color-scheme;
in
{
	hm = {
		services.swaync = {
			enable = true;
			settings = {
				positionX = "right";
				positionY = "top";
				layer = "overlay";
				control-center-layer = "top";
				ignore-gtk-theme = true;
				cssPriority = "user";
				layer-shell = true;

				notification-window-height = 200;
				control-center-height = 500;

				hide-on-clear = false;
				fit-to-screen = false;

				timeout = 10;
				timeout-low = 5;
				timeout-critical = 0;
			};

			style = ./swaync.css;
		};

		home.file.".config/swaync/colors.css".text = gtkPalette;
		home.file.".config/swaync/font.css".text = ''* { font-family: "${config.aether.theme.fonts.regular}"; }'';

		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = SUPER, N, exec, swaync-client -t
			'';
		};
	};
}
