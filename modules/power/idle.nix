{ config, lib, ... }:
let
	timers = config.aether.power.idle-timers;
in
{
	options.aether.power = with lib; with types; {
		idle-timers = {
			on-battery = {
				dim-screen = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 120;  };
				lock = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 180; };
				turn-off-display = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 240; };
				suspend = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 300; };
			};

			plugged = {
				dim-screen = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = -1; };
				lock = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 900; };
				turn-off-display = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 3600; };
				suspend = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = -1; };
			};
		};
	};

	config = {
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
	};
}
