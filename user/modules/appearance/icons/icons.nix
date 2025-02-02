{ pkgs, lib, config, aether, ... }:

{
	options = with lib; with types; {
		appearance.icons = {
			package = mkOption { type = package; description = "Icons theme package"; default =  pkgs.iconpack-obsidian; };
			name = mkOption { type = str; description = "The name of the icon theme to use"; default = "Obsidian-Purple"; };
		};
	};

	config = {
		home.packages = [
			(pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })
			(aether.pkgs.recolor.override { palette = aether.lib.appearance.getPalette { inherit config; }; })
		];


		gtk.iconTheme = {
			name = "aether-icons";
			package = aether.pkgs.icons;
		};
	};
}