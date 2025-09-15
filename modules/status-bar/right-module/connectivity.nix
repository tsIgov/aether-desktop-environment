{ aether, pkgs, ... }:
{
	hm = {
		wayland.windowManager.hyprland = {
			settings = {
				windowrulev2 = [
					"float, class:(pulsemixer)"
					"center, class:(pulsemixer)"
					"size 50% 50%, class:(pulsemixer)"
				];
			};
		};

		programs.waybar = {
			enable = true;
			systemd = {
				enable = true;
				target = "hyprland-session.target";
			};
			settings = {
				mainBar = {

					"group/connectivity" = {
						orientation = "horizontal";
						modules = [
							"custom/connectivity-left"
							"pulseaudio"
							"pulseaudio#source"
							"bluetooth"
							"network"
							"custom/connectivity-right"
						];
					};

					"custom/connectivity-left" = { format = ""; tooltip = false; };
					"custom/connectivity-right" = { format = ""; tooltip = false; };

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
						on-click-right = "rfkill toggle wifi";
					};
					bluetooth = {
						format = "󰂯";
						format-connected = "󰂱";
						format-disabled = "󰂲";
						format-off = "󰂲";
						format-on = "󰂯";

						tooltip = "true";
						tooltip-format = "{controller_alias}\n\n{num_connections} connected";
						tooltip-format-disabled = "{controller_alias}: disabled";
						tooltip-format-off = "{controller_alias}: off";
						tooltip-format-on = "{controller_alias}: on";
						tooltip-format-connected = "{num_connections} connected\n\n{device_enumerate}";
						tooltip-format-enumerate-connected = "{device_alias}";
						tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_battery_percentage}%";

						on-click = "sh /etc/aether/bluetooth/scripts/bluetooth-menu.sh";
						on-click-right = "rfkill toggle bluetooth";
					};

					pulseaudio = {
						format = "{icon}";
						format-muted = "󰖁";
						format-icons = [ "" "" "" ];

						on-click = "kitty --class wiremix wiremix";
						on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
						on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
						on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";

						tooltip = true;
						tooltip-format = "Volume: {volume}%\n{desc}";
					};

					"pulseaudio/slider" = {
						min = 0;
						max = 100;
						orientation = "horizontal";
					};

					"pulseaudio#source" = {
						format = "{format_source}";
						format-source = "󰍬";
						format-source-muted = "󰍭";

						on-click = "kitty --class wiremix wiremix";
						on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
						on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +2%";
						on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -2%";

						tooltip = false;
					};
				};
			};
		};
	};
}
