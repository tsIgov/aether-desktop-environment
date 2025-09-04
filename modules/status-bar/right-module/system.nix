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
							"custom/system-left"
							"custom/system"
							"custom/disk"
							"custom/system-right"
						];
					};

					"custom/system-left" = { format = ""; tooltip = false; };
					"custom/system-right" = { format = ""; tooltip = false; };

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
						on-click = "kitty --class btm btm";
					};

				};
			};
		};
	};
}
