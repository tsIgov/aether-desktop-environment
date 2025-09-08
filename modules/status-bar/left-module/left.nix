{ aether, pkgs, ... }:
{
	hm = {
		programs.waybar = {
			settings = {
				mainBar = {
					"hyprland/window" = {
						separate-outputs = true;
						icon = true;
						icon-size = 18;
						format = "{initialTitle}";
					};
				};
			};
		};
	};
}
