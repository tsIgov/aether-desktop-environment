{ pkgs, lib, config, ... }:

{
	options = with lib; with types; {
		appearance.icons = {
			package = mkOption { type = package; description = "Icons theme package"; default =  pkgs.iconpack-obsidian; };
			name = mkOption { type = str; description = "The name of the icon theme to use"; default = "Obsidian-Purple"; };
		};
	};

	config = {
		gtk.iconTheme = {
			name = config.appearance.icons.name;
			package = config.appearance.icons.package;
		};
	};
}