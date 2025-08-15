{
	home = { lib, aether, pkgs, ... }:
	{
		options.aether.power = with lib; with types; {
			idle-timers = {
				dim-screen = {
					on-battery = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 120;  };
					plugged = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = -1; };
				};

				lock = {
					on-battery = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 180; };
					plugged = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 900; };
				};

				turn-off-display = {
					on-battery = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 240; };
					plugged = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 3600; };
				};

				suspend = {
					on-battery = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = 300; };
					plugged = mkOption { type = int; description = "Timeout in seconds. -1 to disable."; default = -1; };
				};
			};
		};
	};

}
