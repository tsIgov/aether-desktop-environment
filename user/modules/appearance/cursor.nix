{ pkgs, lib, config, ... }:
let 
	flavorName = config.aether.appearance.flavor;
	accent = config.aether.appearance.accent;

	cursorSize = 22;
	cursonName = "catppuccin-${flavorName}-${accent}-cursors";
	packageOutput = flavorName + (lib.toUpper (lib.substring 0 1 accent)) + (lib.substring 1 (builtins.stringLength accent - 1) accent);
in
{
	gtk.cursorTheme = {
		name = cursonName;
		package = pkgs.catppuccin-cursors.${packageOutput};
		size = cursorSize;
	};

	home.sessionVariables = {
		HYPRCURSOR_THEME = cursonName;
		HYPRCURSOR_SIZE = cursorSize;
	};
}