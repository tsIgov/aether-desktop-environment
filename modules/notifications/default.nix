{
	home = { config, aether, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
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

			style = ./style.css;
		};

		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = SUPER, N, exec, swaync-client -t
			'';
		};
	};
}
