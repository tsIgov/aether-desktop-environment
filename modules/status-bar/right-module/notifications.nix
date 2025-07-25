{
	home = { aether, pkgs, ... }:
	{
		programs.waybar = {
			settings = {
				mainBar = {
					"group/notifications" = {
						orientation = "horizontal";
						modules = [
							"custom/notifications-left"
							"tray"
							"custom/notifications"
						];
					};

					"custom/notifications-left" = { format = ""; tooltip = false; };

					"custom/notifications" = {
						tooltip = false;
						format = "{icon}";
						format-icons = {
							none = "";
							notification = "";
							inhibited-none = "";
							inhibited-notification = "";
							dnd-none = "";
							dnd-notification = "";
							dnd-inhibited-none = "";
							dnd-inhibited-notification = "";
						};
						return-type = "json";
						exec-if = "which swaync-client";
						exec = "swaync-client -swb";
						on-click = "swaync-client -t -sw";
						on-click-right = "swaync-client -d -sw";
						escape = true;
					};

					tray = {
						icon-size = 15;
						show-pasive-items = true;
						smooth-scrolling-threshold = 1;
						spacing = 4;
					};
				};
			};
		};
	};
}
