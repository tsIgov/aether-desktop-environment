{
	home = { config, lib, ... }:
	let
		cfg = config.aether.input;
		kblayouts = lib.strings.concatStringsSep "," (builtins.map (layout: layout.name) cfg.keyboard.layouts);
		kbvariants = lib.strings.concatStringsSep "," (builtins.map (layout: layout.variant) cfg.keyboard.layouts);
	in
	{
		wayland.windowManager.hyprland = {
			settings.input = {
				kb_layout = kblayouts;
				kb_variant = kbvariants;
				kb_options = "grp:caps_toggle";
				numlock_by_default = true;
			};
		};
	};
}
