{

	home = { config, pkgs, ... }:
	let 
		flavorName = config.aether.appearance.colors.flavor;
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

			gtk3.extraConfig = {
				Settings = ''
					gtk-application-prefer-dark-theme=1
					color-scheme=prefer-dark
				'';
			};

			gtk4.extraConfig = {
				Settings = ''
					gtk-application-prefer-dark-theme=1
					color-scheme=prefer-dark
				'';
			};
		};

		dconf.settings = {
			"org/gnome/desktop/interface" = {
				color-scheme = "prefer-dark";
			};
		};
	};
	
}