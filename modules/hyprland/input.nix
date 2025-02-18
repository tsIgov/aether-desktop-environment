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

				sensitivity = cfg.mouse.sensitivity;
				follow_mouse = 2;
				float_switch_override_focus = 0;

				scroll_method = "2fg";

				touchpad = {
					natural_scroll = true;

					clickfinger_behavior = true;
					tap-to-click = true;

					drag_lock = true;
					tap-and-drag = true;
				};
			};
		};
	};
}
