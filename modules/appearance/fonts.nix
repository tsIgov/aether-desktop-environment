{

	system = { pkgs, config, ... }:
	{
	    fonts = {
			packages = with pkgs; [
				inter
				nerd-fonts.hack
				noto-fonts-monochrome-emoji
			];
			fontconfig = {
				enable = true;
				defaultFonts = {
					serif = [ config.aether.appearance.fonts.regular ];
					sansSerif = [ config.aether.appearance.fonts.regular ];
					monospace = [ config.aether.appearance.fonts.mono ];
					emoji = [ config.aether.appearance.fonts.emoji ];
				};
			};
		};
	};

	home = { config, ... }:
	{
		fonts.fontconfig = {
			enable = true;
			defaultFonts = {
				serif = [ config.aether.appearance.fonts.regular ];
				sansSerif = [ config.aether.appearance.fonts.regular ];
				monospace = [ config.aether.appearance.fonts.mono ];
				emoji = [ config.aether.appearance.fonts.emoji ];
			};
		};
	};

}