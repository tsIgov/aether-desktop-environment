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
						timeout = timers.dim-screen.on-battery;
						on-timeout = "brightnessctl -s && systemd-ac-power || brightnessctl set 10";
						on-resume = "brightnessctl -r";
					}

					{
						timeout = timers.lock.on-battery;
						on-timeout = "systemd-ac-power || loginctl lock-session";
					}

					{
						timeout = timers.turn-off-display.on-battery;
						on-timeout = "systemd-ac-power || hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}

					{
						timeout = timers.suspend.on-battery;
						on-timeout = "systemd-ac-power || systemctl suspend";
					}


					# plugged in
					{
						timeout = timers.dim-screen.plugged;
						on-timeout = "brightnessctl -s && systemd-ac-power && brightnessctl set 10";
						on-resume = "brightnessctl -r";
					}

					{
						timeout = timers.lock.plugged;
						on-timeout = "systemd-ac-power && loginctl lock-session";
					}

					{
						timeout = timers.turn-off-display.plugged;
						on-timeout = "systemd-ac-power && hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}

					{
						timeout = timers.suspend.plugged;
						on-timeout = "systemd-ac-power && systemctl suspend";
					}
				];
			};
		};
	};
}
