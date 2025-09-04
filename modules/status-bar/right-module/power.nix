{
	home = { aether, pkgs, ... }:
	{
		programs.waybar = {
			enable = true;
			systemd = {
				enable = true;
				target = "hyprland-session.target";
			};
			settings = {
				mainBar = {
					"group/system" = {
						orientation = "horizontal";
						modules = [
							"custom/power-left"
							"idle_inhibitor"
							"backlight"
							"power-profiles-daemon"
							"battery"
							"custom/power-right"
						];
					};

					"custom/power-left" = { format = ""; tooltip = false; };
					"custom/power-right" = { format = ""; tooltip = false; };

					backlight = {
						format = "{icon}";
						format-icons = [ "󰛩" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
						on-scroll-down = "brightnessctl set 2%-";
						on-scroll-up = "brightnessctl set +2%";
						tooltip = true;
						tooltip-format = "{percent}%";
					};
					battery = {
						states = {
							warning = 30;
							critical = 15;
						};

						format = "{icon}";
						format-charging = "󰂄";
						format-full = "󰂄";
						format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];

						tooltip = true;
						tooltip-format = "{capacity}%\n{timeTo}";
					};
					power-profiles-daemon = {
						format = "{icon}";
						tooltip-format = "Power profile: {profile}\nDriver: {driver}";
						tooltip = true;
						format-icons = {
							default = "";
							performance = "";
							balanced = "";
							power-saver = "";
						};
					};

					idle_inhibitor = {
						format = "{icon}";
						format-icons = {
							activated = "";
							deactivated = "";
						};
						tooltip-format-activated = "Idling inhibited";
						tooltip-format-deactivated = "Idling enabled";
					};
				};
			};
		};
	};
}
