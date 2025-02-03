{ config, ... }:

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
			];

			workspace = [
				"special:a, gapsout:100"
				"special:s, gapsout:100, on-created-empty:${config.aether.defaultApps.terminal}"
				"special:d, gapsout:100, on-created-empty:${config.aether.defaultApps.fileManager}"
			];
		};

	};
}

