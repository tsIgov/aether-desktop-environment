let
	opt = { lib, aether, ... }:
	with lib; with types; {
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
in
{

	system = args:
	{
		options.aether.appearance = opt args;
	};

	home = { lib, ... }@args:
	{
		options.aether.appearance = (opt args) // (with lib; with types; {
			cursorSize =  mkOption { type = ints.positive; default = 22; };
		});
	};

}