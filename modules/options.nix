{

	system = { lib, aether, ... }:
	{
		options.aether = with lib; with types; {
			appearance = {
				colors = {
					flavor = mkOption { type = enum aether.lib.appearance.validFlavors; default = "mocha"; };
					accent = mkOption { type = enum aether.lib.appearance.validAccents; default = "mauve"; };
				};
				fonts = {
					size = mkOption { type = ints.positive; default = 11; };
					regular = mkOption { type = str; default = "Inter"; };
					mono = mkOption { type = str; default = "Hack Nerd Font Mono"; };
					emoji = mkOption { type = str; default = "Noto Emoji"; };
				};
			};

			garbageCollection = {
				enable = mkOption { type = bool; default = true; description = "Automatically run the garbage collector."; };
				schedule = mkOption { type = singleLineStr; default = "Mon 06:00"; description = "How often or when garbage collection is performed. This value must be a calendar event in the format specified by {manpage}`systemd.time(7)`."; };
				daysOld = mkOption { type = ints.positive; default = 7; description = "Delete all inactive generations older than the specified amount of days."; };
			};

			hardware = {
				laptop = mkOption { type = bool; default = true; };

				nvidia = with lib; with types; {
					enable = mkOption { type = bool; default = false; };
					drivers = mkOption { type = enum [ "nvidia" "nvidia-proprietary" "nouveau" "disabled" ]; default = "nvidia"; };
					prime = {
						enable = mkOption { type = bool; default = false; };
						type = mkOption { type = enum [ "offload" "sync" "reverseSync" ]; default = "offload"; };
					};
				};
			};

			virtualization = {
				docker.enable = mkOption { type = bool; default = false; };
			};
		};
	};

	home = { lib, aether, pkgs, ... }:
	{
		options.aether = with lib; with types; {
			appearance = {
				colors = {
					flavor = mkOption { type = enum aether.lib.appearance.validFlavors; default = "mocha"; };
					accent = mkOption { type = enum aether.lib.appearance.validAccents; default = "mauve"; };
				};
				fonts = {
					size = mkOption { type = ints.positive; default = 11; };
					regular = mkOption { type = str; default = "Inter"; };
					mono = mkOption { type = str; default = "Hack Nerd Font Mono"; };
					emoji = mkOption { type = str; default = "Noto Emoji"; };
				};
				cursorSize =  mkOption { type = ints.positive; default = 22; };
			};

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

			defaultApps = with lib; with types; {
				terminal = mkOption { type = pathInStore; default = "${pkgs.kitty}/bin/kitty"; };
				fileManager = mkOption { type = pathInStore; default = "${pkgs.nemo}/bin/nemo"; };
			};

			directories = {
				screenshot = mkOption { type = str; default = "~/Screenshots"; };
			};
		};
	};

}
