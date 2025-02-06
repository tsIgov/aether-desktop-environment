{
	home = { config, ... }:
	{
		wayland.windowManager.hyprland = {
			settings.input = {
				kb_layout = "us,bg";
				kb_variant = ",phonetic";
				kb_options = "grp:caps_toggle";
				numlock_by_default = true;

				sensitivity = config.aether.input.mouseSensitivity;
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
