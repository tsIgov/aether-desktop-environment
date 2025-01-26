{ pkgs, aetherLib, ... }:

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
				serif = [ aetherLib.appearance.fonts.regular ];
				sansSerif = [ aetherLib.appearance.fonts.regular ];
				monospace = [ aetherLib.appearance.fonts.mono ];
				emoji = [ aetherLib.appearance.fonts.emoji ];
			};
		};
	};
}
