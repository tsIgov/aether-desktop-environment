{
	home = { ... }:
	{

		wayland.windowManager.hyprland = {
			settings = {
				general = {
					layout = "scroller";
				};
				master = {
					mfact = 0.7;
					new_status = "slave";
				};

				plugin = {
					scroller = {
						column_default_width = "one";
						window_default_height = "one";
						focus_wrap = 0;
						center_row_if_space_available = 1;
						cyclesize_wrap = 0;
						column_widths = "onethird onehalf twothirds one";
						window_heights = "onethird onehalf twothirds one";
					};
				};
			};

		};
	};
}
