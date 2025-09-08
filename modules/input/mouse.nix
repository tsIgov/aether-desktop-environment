{ config, ... }:
let
	cfg = config.aether.input;
in
{
	hm = {
		wayland.windowManager.hyprland = {
			settings.input = {
				sensitivity = cfg.mouse.sensitivity;
			};
		};
	};
}
