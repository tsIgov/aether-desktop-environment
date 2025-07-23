{
	home = { ... }:
	{
		wayland.windowManager.hyprland = {
			settings.input = {
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
