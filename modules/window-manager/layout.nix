{ ... }:
{
	hm = {
		wayland.windowManager.hyprland = {
			settings = {
				general = {
					layout = "master";
				};
				master = {
					mfact = 0.5;
					new_status = "slave";
					inherit_fullscreen = false;
					allow_small_split = false;
					# orientation = "center";
					# slave_count_for_center_master = 4;
					# center_master_fallback = "left";

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
