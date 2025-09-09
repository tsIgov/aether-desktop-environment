{ pkgs, lib, config, ... }:
let
	inherit (lib) mkOptions;
	inherit (lib.types) ints;

	flavorName = config.aether.appearance.colors.flavor;
	accent = config.aether.appearance.colors.primary;

	cursorName = "catppuccin-${flavorName}-${accent}-cursors";
	packageOutput = flavorName + (lib.toUpper (lib.substring 0 1 accent)) + (lib.substring 1 (builtins.stringLength accent - 1) accent);
in
{
	options.aether.appearance = with lib; with types; {
		cursorSize =  mkOption { type = ints.positive; default = 22; };
	};

	config = {
		hm = {
			gtk.cursorTheme = {
				name = cursorName;
				package = pkgs.catppuccin-cursors.${packageOutput};
				size = config.aether.appearance.cursorSize;
			};

			home.sessionVariables = {
				HYPRCURSOR_THEME = cursorName;
				HYPRCURSOR_SIZE = config.aether.appearance.cursorSize;
			};
		};
	};
}
