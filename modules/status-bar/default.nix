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
					layer = "top";
					position = "top";
					margin-left = 10;
					margin-right = 10;
					margin-top = 10;
					margin-bottom = 0;
					fixed-center = true;
					reload_style_on_change = true;

					modules-left = [
						"hyprland/window"
					];

					modules-center = [
						"custom/center-l1l"
						"clock#cal"
						"custom/center-l1r"

						"custom/center-cl"
						"hyprland/workspaces"
						"custom/center-cr"

						"custom/center-r1l"
						"clock#time"
						"custom/center-r1r"
					];

					modules-right = [
						"custom/right-4l"
						"hyprland/submap"
						"hyprland/language"
						"custom/right-4r"

						"custom/right-3l"
						"pulseaudio"
						"pulseaudio#source"
						"bluetooth"
						"network"
						"custom/right-3r"

						"custom/right-2l"
						"group/power"
						"custom/system"
						"custom/disk"
						"custom/right-2r"

						"custom/right-1l"
						"tray"
						"custom/notifications"
					];


					"custom/center-cl" = { format = ""; tooltip = false; };
					"custom/center-cr" = { format = ""; tooltip = false; };

					"custom/center-l1l" = { format = ""; tooltip = false; };
					"custom/center-l1r" = { format = ""; tooltip = false; };

					"custom/center-r1l" = { format = ""; tooltip = false; };
					"custom/center-r1r" = { format = ""; tooltip = false; };

					"custom/right-1l" = { format = ""; tooltip = false; };
					"custom/right-2l" = { format = ""; tooltip = false; };
					"custom/right-2r" = { format = ""; tooltip = false; };
					"custom/right-3l" = { format = ""; tooltip = false; };
					"custom/right-3r" = { format = ""; tooltip = false; };
					"custom/right-4l" = { format = ""; tooltip = false; };
					"custom/right-4r" = { format = ""; tooltip = false; };

					# █    "


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

						on-click = "sh /etc/aether/network/scripts/network-menu.sh";
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

						on-click = "sh /etc/aether/bluetooth/scripts/bluetooth-menu.sh";
						on-click-right = "rfkill toggle bluetooth";
					};

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

						on-click = "sh /etc/aether/audio/scripts/audio-menu.sh sink";
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

						on-click = "sh /etc/aether/audio/scripts/audio-menu.sh source";
						on-click-middle = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
						on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +2%";
						on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -2%";

						tooltip = true;
					};
					"custom/notifications" = {
						"tooltip" = false;
						"format" = "{icon}";
						"format-icons" = {
							"none" = "";
							"notification" = "";
							"inhibited-none" = "";
							"inhibited-notification" = "";
							"dnd-none" = "";
							"dnd-notification" = "";
							"dnd-inhibited-none" = "";
							"dnd-inhibited-notification" = "";
						};
						"return-type" = "json";
						"exec-if" = "which swaync-client";
						"exec" = "swaync-client -swb";
						"on-click" = "swaync-client -t -sw";
						"on-click-right" = "swaync-client -d -sw";
						"escape" = true;
					};


					tray = {
						icon-size = 15;
						show-pasive-items = true;
						smooth-scrolling-threshold = 1;
						spacing = 4;
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
	};
}
