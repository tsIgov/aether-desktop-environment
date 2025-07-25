{
	home = { aether, pkgs, ... }:
	{
		programs.waybar = {
			settings = {
				mainBar = {
					"group/keyboard" = {
						orientation = "horizontal";
						modules = [
							"custom/keyboard-left"
							"hyprland/submap"
							"hyprland/language"
							"custom/keyboard-right"
						];
					};

					"custom/keyboard-left" = { format = ""; tooltip = false; };
					"custom/keyboard-right" = { format = ""; tooltip = false; };

					"hyprland/language" = {
						format = "{}";
						format-en = "EN";
						format-bg = "BG";
					};
					"hyprland/submap" = {
						format = "";
						max-length = 8;
						tooltip = false;
						always-on = true;
					};
				};
			};
		};
	};
}
