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
		};
	};

	home = { lib, aether, pkgs, ... }:
	{
		options.aether = with lib; with types; {
			appearance = {
				colors = {
					flavor = mkOption { type = enum aether.lib.appearance.validFlavors; default = "mocha"; };
					primary = mkOption { type = enum aether.lib.appearance.validAccents; default = "mauve"; };
					secondary = mkOption { type = enum aether.lib.appearance.validAccents; default = "green"; };
					tertiary = mkOption { type = enum aether.lib.appearance.validAccents; default = "peach"; };
					error = mkOption { type = enum aether.lib.appearance.validAccents; default = "red"; };
				};
				fonts = {
					size = mkOption { type = ints.positive; default = 11; };
					regular = mkOption { type = str; default = "Inter"; };
					mono = mkOption { type = str; default = "Hack Nerd Font Mono"; };
					emoji = mkOption { type = str; default = "Noto Emoji"; };
					icons = mkOption { type = str; default = "Hack Nerd Font Propo"; };
				};
				cursorSize =  mkOption { type = ints.positive; default = 22; };
				wallpaper = mkOption { type = enum [ "deer" ]; default = "deer"; };
			};

		};
	};

}
