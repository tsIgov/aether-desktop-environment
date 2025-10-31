{ config, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str nullOr package bool;

	cfg = config.aether.theme.gtk;
	colorScheme = if cfg.dark then "dark" else "light";
in
{
	options.aether.theme = {
		gtk = {
			theme-name = mkOption { type = str; default = ""; };
			theme-package =  mkOption { type = nullOr package; default = null; };
			dark = mkOption { type = bool; default = true; };
		};
	};

	config = {
		hm = {
			gtk = {
				enable = true;
				theme = {
					name = cfg.theme-name;
					package = cfg.theme-package;
				};
			};

			dconf.settings = {
				"org/gnome/desktop/interface" = { color-scheme = "prefer-${colorScheme}"; };
				"org.gtk.Settings.Debug" = {enable-inspector-keybinding = true; };
			};
		};
	};
}
