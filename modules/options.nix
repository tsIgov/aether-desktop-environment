{

	system = { lib, aether, ... }:
	{
		options.aether = with lib; with types; {
			garbageCollection = {
				enable = mkOption { type = bool; default = true; description = "Automatically run the garbage collector."; };
				schedule = mkOption { type = singleLineStr; default = "Mon 06:00"; description = "How often or when garbage collection is performed. This value must be a calendar event in the format specified by {manpage}`systemd.time(7)`."; };
				daysOld = mkOption { type = ints.positive; default = 7; description = "Delete all inactive generations older than the specified amount of days."; };
			};

		};
	};

	home = { lib, aether, pkgs, ... }:
	{
		options.aether = with lib; with types; {
			input = {
				mouse = {
					sensitivity = mkOption { type = float; default = 0.0; apply = x: if x >= -1.0 && x <= 1.0 then x else throw "mouseSensitivity must be a value between -1 and 1";};
				};

				keyboard = {
					layouts = mkOption {
						type = listOf (submodule {
							options = {
								name = mkOption { type = str; };
								variant = mkOption { type = str; default = ""; };
							};
						});
					};
				};
			};

			defaultApps = {
				terminal = mkOption { type = pathInStore; default = "${pkgs.kitty}/bin/kitty"; };
				fileManager = mkOption { type = pathInStore; default = "${pkgs.nemo}/bin/nemo"; };
			};

		};
	};

}
