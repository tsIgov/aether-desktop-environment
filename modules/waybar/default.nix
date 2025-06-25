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
					layer = "top";
					position = "top";
					margin = "10";
					fixed-center = true;
					reload_style_on_change = true;

					modules-left = [
						"hyprland/window"
					];

					modules-center = [
						"custom/center-l2l"
						"hyprland/submap"
						"hyprland/language"
						"custom/center-l2r"

						"custom/center-l1l"
						"clock#cal"
						"custom/center-l1r"

						"custom/center-cl"
						"hyprland/workspaces"
						"custom/center-cr"

						"custom/center-r1l"
						"clock#time"
						"custom/center-r1r"

						"custom/center-r2l"
						"pulseaudio"
						"pulseaudio#source"
						"custom/notifications"
						"custom/center-r2r"
					];

					modules-right = [
						"custom/right-4l"
						"network"
						"bluetooth"
						"custom/right-4r"

						"custom/right-3l"
						"battery"
						"power-profiles-daemon"
						"backlight"
						"custom/right-3r"

						"custom/right-2l"
						"group/status"
						"custom/right-2r"

						"custom/right-1l"
						"tray"
						"custom/right-1r"
					];


					"custom/center-cl" = { format = ""; tooltip = false; };
					"custom/center-cr" = { format = ""; tooltip = false; };

					"custom/center-l1l" = { format = ""; tooltip = false; };
					"custom/center-l1r" = { format = ""; tooltip = false; };
					"custom/center-l2l" = { format = ""; tooltip = false; };
					"custom/center-l2r" = { format = ""; tooltip = false; };

					"custom/center-r1l" = { format = ""; tooltip = false; };
					"custom/center-r1r" = { format = ""; tooltip = false; };
					"custom/center-r2l" = { format = ""; tooltip = false; };
					"custom/center-r2r" = { format = ""; tooltip = false; };

					"custom/right-1l" = { format = ""; tooltip = false; };
					"custom/right-1r" = { format = ""; tooltip = false; };
					"custom/right-2l" = { format = ""; tooltip = false; };
					"custom/right-2r" = { format = ""; tooltip = false; };
					"custom/right-3l" = { format = ""; tooltip = false; };
					"custom/right-3r" = { format = ""; tooltip = false; };
					"custom/right-4l" = { format = ""; tooltip = false; };
					"custom/right-4r" = { format = ""; tooltip = false; };


					"group/status" = {
						orientation = "horizontal";
						modules = [
							"custom/cpu"
							"custom/temperature"
							"custom/memory"
							"custom/disk"
						];
					};
					"custom/disk" = {
						interval = 30;
						exec = "sh $HOME/.config/waybar/scripts/disk.sh 2> /dev/null";
						"return-type" = "json";
						format = "{icon}";
						"format-icons" = ["󰝦" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
					};
					"custom/cpu" = {
						interval = 10;
						exec = "sh $HOME/.config/waybar/scripts/cpu.sh 2> /dev/null";
						"return-type" = "json";
						format = "";
					};
					"custom/temperature" = {
						interval = 10;
						exec = "sh $HOME/.config/waybar/scripts/temperature.sh 2> /dev/null";
						"return-type" = "json";
						format = "{icon}";
						"format-icons" = ["" "" "" "" ""];
					};
					"custom/memory" = {
						interval = 10;
						exec = "sh $HOME/.config/waybar/scripts/memory.sh 2> /dev/null";
						"return-type" = "json";
						format = "";
					};


					"clock#time" = {
						format = " {:%H:%M}";
						interval = 1;
						tooltip = true;
						tooltip-format = "{:%H:%M:%S}";
					};

					"clock#cal" = {
						format = "󰸗 {:%d %a}";
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


					network = {
						format-wifi = "{icon}";
						format-disconnected = "󰤫";
						format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
						format-ethernet = "󱂇";
						format-disabled = "󰤮";

						tooltip-format = "{ifname}\nIP: {ipaddr}\nDownload: {bandwidthDownBytes}\nUpload: {bandwidthUpBytes}";
						tooltip-format-wifi = "ESSID: {essid}\nFrequency: {frequency} GHz\nStrength: {signalStrength}%\nIP: {ipaddr}\nDownload: {bandwidthDownBytes}\nUpload: {bandwidthUpBytes}";
						tooltip-format-disconnected = "Disconnected";

						on-click = "rofi-network-manager";
						on-click-middle = "rfkill toggle wifi";
					};
					bluetooth = {
						format = "󰂯";
						format-connected = "󰂱";
						format-disabled = "󰂲";
						format-off = "󰂲";
						format-on = "󰂯";

						tooltip = "true";
						tooltip-format = "{controller_alias}\n\n{num_connections} connected";
						tooltip-format-disabled = "";
						tooltip-format-off = "";
						tooltip-format-on = "";
						tooltip-format-connected = "{num_connections} connected\n\n{device_enumerate}";
						tooltip-format-enumerate-connected = "{device_alias}";
						tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_battery_percentage}%";

						on-click = "rofi-bluetooth";
						on-click-right = "rfkill toggle bluetooth";
					};


					backlight = {
						format = "{icon}";
						format-icons = [ "󰛩" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
						on-scroll-down = "brightnessctl set 2%-";
						on-scroll-up = "brightnessctl set +2%";
						tooltip = false;
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


					pulseaudio = {
						format = "{icon}";
						format-muted = "󰖁";
						format-icons = [ "" "" "" ];

						on-click = "rofi-pulse-select sink";
						on-click-middle = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
						on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
						on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";

						tooltip = true;
						tooltip-format = "Volume: {volume}%\n{desc}";
					};
					"pulseaudio#source" = {
						format = "{format_source}";
						format-source = "󰍬";
						format-source-muted = "󰍭";

						on-click = "rofi-pulse-select source";
						on-click-middle = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
						on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +2%";
						on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -2%";

						tooltip = false;
					};
					"custom/notifications" = {
						"tooltip" = false;
						"format" = "{icon}";
						"format-icons" = {
							"notification" = "󰂚<span foreground='red'><sup></sup></span>";
							"none" = "󰂚";
							"dnd-notification" = "󰂛<span foreground='red'><sup></sup></span>";
							"dnd-none" = "󰂛";
							"inhibited-notification" = "󰂚<span foreground='red'><sup></sup></span>";
							"inhibited-none" = "󰂚";
							"dnd-inhibited-notification" = "󰂛<span foreground='red'><sup></sup></span>";
							"dnd-inhibited-none" = "󰂛";
						};
						"return-type" = "json";
						"exec-if" = "which swaync-client";
						"exec" = "swaync-client -swb";
						"on-click" = "swaync-client -t -sw";
						"on-click-right" = "swaync-client -d -sw";
						"escape" = true;
					};


					tray = {
						icon-size = 20;
						show-pasive-items = true;
						smooth-scrolling-threshold = 1;
						spacing = 3;
					};


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


					"hyprland/window" = {
						separate-outputs = true;
						icon = true;
						format = "{initialTitle}";
					};


					"hyprland/workspaces" = {
						active-only = false;
						all-outputs = true;
						format = "{icon}";
						show-special = false;
						special-visible-only = false;
						format-icons = {
							default = "";
							# active = "";
							#
							empty = "";
							# special = "";
						};
						persistent-workspaces = {
							"1" = [];
							"2" = [];
							"3" = [];
							"4" = [];
							"5" = [];
						};
						ignore-workspaces = ["6"];
						sort-by = "name";
					};
				};
			};
			style = ./style.css;
		};

		home.file.".config/waybar/colors.css".source = ./colors.css;
		home.file.".config/waybar/scripts".source = ./scripts;
	};
}
