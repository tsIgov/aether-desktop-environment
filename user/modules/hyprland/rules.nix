{ ... }:

{

	wayland.windowManager.hyprland = {
		settings = {

			windowrule = [
				"float, Rofi"
			];

			windowrulev2 = [
				"opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
				"noanim,class:^(xwaylandvideobridge)$"
				"nofocus,class:^(xwaylandvideobridge)$"
				"noinitialfocus,class:^(xwaylandvideobridge)$"

			 "stayfocused, class:Rofi"
			 "pin, class:Rofi"
			 "noanim, class:Rofi"


			];

			workspace = [
				"special:scratchpad, gapsout:200, on-created-empty:foot"
			];
		};

	};
}

