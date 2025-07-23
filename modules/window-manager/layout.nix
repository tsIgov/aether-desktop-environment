{
	home = { ... }:
	{

		wayland.windowManager.hyprland = {
			settings = {
				general = {
					layout = "master";
				};
				master = {
					mfact = 0.7;
					new_status = "slave";
					inherit_fullscreen = false;
					allow_small_split = false;
				};
				group = {
					insert_after_current = false;
				};
			};

		};
	};
}
