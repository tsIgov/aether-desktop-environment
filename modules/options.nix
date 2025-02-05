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

			hardware = {
				laptop = mkOption { type = bool; default = true; };
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
				mouseSensitivity = mkOption { type = float; default = 0.0; apply = x: if x >= -1.0 && x <= 1.0 then x else throw "mouseSensitivity must be a value between -1 and 1";};
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
