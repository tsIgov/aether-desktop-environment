{
	home = { pkgs, ... }:
	{
		programs.hyprpanel = {
			settings = {
				bar.windowtitle = {
					class_name = true;
					custom_title = true;
					icon = true;
					label = true;
					truncation = true;
					truncation_size = 46;
				};

				menus.clock = {
					time.hideSeconds = false;
					time.military = true;
					weather.enabled = false;
				};

				theme.bar = {
					buttons.clock.spacing = "0";
					menus.menu.clock.scaling = 90;
				};
			};
		};
	};
}
