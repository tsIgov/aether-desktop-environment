{ pkgs, aether, ... }:

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
				serif = [ aether.lib.appearance.fonts.regular ];
				sansSerif = [ aether.lib.appearance.fonts.regular ];
				monospace = [ aether.lib.appearance.fonts.mono ];
				emoji = [ aether.lib.appearance.fonts.emoji ];
			};
		};
	};
}
