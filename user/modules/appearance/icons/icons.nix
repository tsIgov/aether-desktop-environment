{ pkgs, lib, config, aetherPkgs, ... }:

{
	options = with lib; with types; {
		appearance.icons = {
			package = mkOption { type = package; description = "Icons theme package"; default =  pkgs.iconpack-obsidian; };
			name = mkOption { type = str; description = "The name of the icon theme to use"; default = "Obsidian-Purple"; };
		};
	};

	config = {
		home.packages = with pkgs; [
			(catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })
			(aetherPkgs.recolor.override { flavor = "mocha"; })
		];


		gtk.iconTheme = {
			name = "aether-icons";
			package = aetherPkgs.icons;
		};
	};
}