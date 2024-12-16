{ config, ... }:

{
	wayland.windowManager.hyprland = {
		settings = {
			exec-once = [
				"nm-applet &"
			];
		};
	};
}
