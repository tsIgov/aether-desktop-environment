{ lib, aether, pkgs, ... }:
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
}
