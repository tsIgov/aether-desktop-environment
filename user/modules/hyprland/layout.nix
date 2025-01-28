{ ... }:
{

	wayland.windowManager.hyprland = {
		settings = {
			general = {
				layout = "dwindle";
			};
			master = {
				mfact = 0.7;
				new_status = "slave";
			};
			dwindle = {
				force_split = 2;
				default_split_ratio = 1.1;
			};

		};

	};
}

