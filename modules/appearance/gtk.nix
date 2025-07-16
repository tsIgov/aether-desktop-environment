{

	home = { config, pkgs, ... }:
	let
		flavorName = config.aether.appearance.colors.flavor;
		colorScheme = if flavorName == "latte" then "light" else "dark";
		accent = config.aether.appearance.colors.accent;

	in
	{
		gtk = {
			enable = true;

			theme = {
				name = "catppuccin-${flavorName}-${accent}-standard+normal";
				package = pkgs.catppuccin-gtk.override {
					accents = [ accent ];
					size = "standard";
					tweaks = [ "normal" ];
					variant = flavorName;
				};
			};

			font = {
				name = config.aether.appearance.fonts.mono;
				size = config.aether.appearance.fonts.size;
			};
		};

		dconf.settings = {
			"org/gnome/desktop/interface" = {
				color-scheme = "prefer-${colorScheme}";
			};
			"org.gtk.Settings.Debug" = {enable-inspector-keybinding = true; };
		};
	};

}
