{ pkgs, lib, config, ... }:

{
	options = with lib; with types; {
		appearance.cursor = {
			package = mkOption { type = package; description = "Cursor theme package"; default =  pkgs.bibata-cursors; };
			name = mkOption { type = str; description = "The name of the cursor theme to use"; default = "Bibata-Modern-Classic"; };
			size = mkOption {type = int; description = "Cursor size"; default = 20; };
		};
	};

	config = {
		wayland.windowManager.hyprland.settings.exec-once = [
			"hyprctl setcursor ${config.appearance.cursor.name} ${builtins.toString config.appearance.cursor.size}"
		];

		gtk.cursorTheme = {
			name = config.appearance.cursor.name;
			package = config.appearance.cursor.package;
			size = config.appearance.cursor.size;
		};
	};
}