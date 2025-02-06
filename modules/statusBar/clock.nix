{
	home = { pkgs, ... }:
	{
		programs.hyprpanel = {
			settings = {
				bar.clock = {
					format = "%H:%M:%S";
					showIcon = false;
					showTime = true;
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
