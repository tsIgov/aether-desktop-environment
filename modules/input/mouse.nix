{ config, lib, ... }:
let
	cfg = config.aether.input.mouse;
in
{
	options.aether.input.mouse = with lib; with types; {
		sensitivity = mkOption { type = float; default = 0.0; apply = x: if x >= -1.0 && x <= 1.0 then x else throw "mouseSensitivity must be a value between -1 and 1"; };
	};

	config = {
		hm = {
			wayland.windowManager.hyprland = {
				settings.input = {
					sensitivity = cfg.sensitivity;
				};
			};
		};
	};
}
