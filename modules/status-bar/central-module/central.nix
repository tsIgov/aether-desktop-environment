{
	home = { aether, pkgs, ... }:
	{
		programs.waybar = {
			settings = {
				mainBar = {
					"group/central" = {
						orientation = "horizontal";
						modules = [
							"custom/calendar-left"
							"clock#cal"
							"custom/calendar-right"

							"custom/workspaces-left"
							"hyprland/workspaces"
							"custom/workspaces-right"

							"custom/time-left"
							"clock#time"
							"custom/time-right"
						];
					};

					"custom/workspaces-left" = { format = ""; tooltip = false; };
					"custom/workspaces-right" = { format = ""; tooltip = false; };
					"custom/calendar-left" = { format = ""; tooltip = false; };
					"custom/calendar-right" = { format = ""; tooltip = false; };
					"custom/time-left" = { format = ""; tooltip = false; };
					"custom/time-right" = { format = ""; tooltip = false; };

					"clock#time" = {
						format = "{:%H:%M}";
						interval = 1;
						tooltip = true;
						tooltip-format = "{:%H:%M:%S}";
					};

					"clock#cal" = {
						format = "{:%d %a}";
						interval = 1;
						tooltip = true;
						tooltip-format = "{calendar}";

						calendar = {
							mode = "month";
							weeks-pos = "left";
							on-scroll = 1;
							format = {
								months = "<span color='#d4be98'><b>{}</b></span>";
								weeks = "<span color='#7daea3'><b>W{}</b></span>";
								weekdays = "<span color='#d8a657'><b>{}</b></span>";
								days = "<span color='#d4be98'><b>{}</b></span>";
								today = "<span color='#e78a4e'><b><u>{}</u></b></span>";
							};
						};
						actions = {
							on-scroll-up = "shift_down";
							on-scroll-down = "shift_up";
						};
					};

					"hyprland/workspaces" = {
						active-only = false;
						all-outputs = true;
						format = "{icon}";
						show-special = false;
						special-visible-only = false;
						format-icons = {
							default = "";
							empty = "";
						};
						persistent-workspaces = {
							"1" = [];
							"2" = [];
							"3" = [];
							"4" = [];
							"5" = [];
						};
						ignore-workspaces = [];
						sort-by = "name";
					};
				};
			};
		};
	};
}
