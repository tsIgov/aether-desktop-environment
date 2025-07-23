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
					"special:quick-1, gapsout:100"
					"special:quick-2, gapsout:100"
					"special:quick-3, gapsout:100"
					"special:quick-4, gapsout:100"
					"special:quick-5, gapsout:100"
				];
			};

		};
	};
}
