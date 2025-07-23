{
	home = { config, ... }:
	let
		cfg = config.aether.input;
	in
	{
		wayland.windowManager.hyprland = {
			settings.input = {
				sensitivity = cfg.mouse.sensitivity;
			};
		};
	};
}
