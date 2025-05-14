{
	home = { config, ... }:
	{

		wayland.windowManager.hyprland = {
			settings = {

				windowrulev2 = [
					"opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
					"noanim,class:^(xwaylandvideobridge)$"
					"nofocus,class:^(xwaylandvideobridge)$"
					"noinitialfocus,class:^(xwaylandvideobridge)$"

					# Clipboard manager
					"float,class:(clipse)"
					"size 700 80%,class:(clipse)"

					"plugin:scroller:columnwidth onethird, class:(kitty)"
				];

				workspace = [
					"special:quick, gapsout:100"
				];
			};

		};
	};
}
