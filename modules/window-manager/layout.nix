{ ... }:
{
	hm = {
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

				workspace = [
					"special:quick-1, gapsout:100"
					"special:quick-2, gapsout:100"
					"special:quick-3, gapsout:100"
					"special:quick-4, gapsout:100"
					"special:quick-5, gapsout:100"
				];
			};
		};
	};
}
