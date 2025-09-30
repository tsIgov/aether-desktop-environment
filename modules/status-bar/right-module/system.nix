{ aether, pkgs, ... }:
{
	hm = {
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
							"custom/system"
							"custom/disk"
							"backlight"
							"custom/idle"
							"custom/power-profile"
							"battery"
							"custom/system-right"
						];
					};

					"custom/system-left" = { format = ""; tooltip = false; };
					"custom/system-right" = { format = ""; tooltip = false; };

					"custom/disk" = {
						interval = 30;
						exec = "/etc/aether/status-bar/scripts/disk.sh 2> /dev/null";
						"return-type" = "json";
						format = "{icon}";
						"format-icons" = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
					};
					"custom/system" = {
						interval = 10;
						exec = "/etc/aether/status-bar/scripts/system.sh 2> /dev/null";
						"return-type" = "json";
						format = "";
						on-click = "kitty --class btm btm";
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

					"custom/idle" = {
						interval = 1;
						exec = "/etc/aether/status-bar/scripts/idle.sh 2> /dev/null";
						"return-type" = "json";
						format = "";
						on-click = "/etc/aether/power/scripts/inhibition-toggle.sh";
					};

					"custom/power-profile" = {
						interval = 10;
						exec = "/etc/aether/status-bar/scripts/power-profile.sh 2> /dev/null";
						"return-type" = "json";
						format = "{icon}";
						format-icons = {
							default = "";
							performance = "";
							powersave = "";
						};
						on-click = "sudo auto-cpufreq --force reset";
					};
				};
			};
		};
	};
}
