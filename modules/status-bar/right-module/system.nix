{
	system = { hostName, ... }:
	{
		environment.etc."aether/status-bar/scripts".source = ./scripts;
	};

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
							"custom/system-left"
							"group/power"
							"custom/system"
							"custom/disk"
							"custom/system-right"
						];
					};

					"custom/system-left" = { format = ""; tooltip = false; };
					"custom/system-right" = { format = ""; tooltip = false; };

					"group/power" = {
						orientation = "horizontal";
						modules = [
							"battery"
							"power-profiles-daemon"
							"backlight"
						];
						drawer = {
							"click-to-reveal" = false;
							"transition-left-to-right" = false;
						};
					};

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

					"custom/disk" = {
						interval = 30;
						exec = "sh /etc/aether/status-bar/scripts/disk.sh 2> /dev/null";
						"return-type" = "json";
						format = "{icon}";
						"format-icons" = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
					};
					"custom/system" = {
						interval = 10;
						exec = "sh /etc/aether/status-bar/scripts/system.sh 2> /dev/null";
						"return-type" = "json";
						format = "";
					};
				};
			};
		};
	};
}
