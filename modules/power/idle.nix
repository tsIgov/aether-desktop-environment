{ config, ... }:
let
	timers = config.aether.power.idle-timers;
in
{
	hm = {
		services.hypridle = {
			enable = true;
			settings = {
				general = {
					lock_cmd = "pidof hyprlock || hyprlock";
					before_sleep_cmd = "loginctl lock-session";
					after_sleep_cmd = "hyprctl dispatch dpms on";
				};

				listener = [
					# on battery
					{
						timeout = timers.on-battery.dim-screen;
						on-timeout = "brightnessctl -s && systemd-ac-power || brightnessctl set 10";
						on-resume = "brightnessctl -r";
					}

					{
						timeout = timers.on-battery.lock;
						on-timeout = "systemd-ac-power || loginctl lock-session";
					}

					{
						timeout = timers.on-battery.turn-off-display;
						on-timeout = "systemd-ac-power || hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}

					{
						timeout = timers.on-battery.suspend;
						on-timeout = "systemd-ac-power || systemctl suspend";
					}


					# plugged in
					{
						timeout = timers.plugged.dim-screen;
						on-timeout = "brightnessctl -s && systemd-ac-power && brightnessctl set 10";
						on-resume = "brightnessctl -r";
					}

					{
						timeout = timers.plugged.lock;
						on-timeout = "systemd-ac-power && loginctl lock-session";
					}

					{
						timeout = timers.plugged.turn-off-display;
						on-timeout = "systemd-ac-power && hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}

					{
						timeout = timers.plugged.suspend;
						on-timeout = "systemd-ac-power && systemctl suspend";
					}
				];
			};
		};
	};
}
