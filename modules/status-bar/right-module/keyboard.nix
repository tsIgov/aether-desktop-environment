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
						format = "<span text_transform=\"uppercase\">{shortDescription}</span>";
					};
					"hyprland/submap" = {
						format = "";
						max-length = 8;
						tooltip = false;
						always-on = false;
					};
				};
			};
		};
	};
}
