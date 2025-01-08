{ pkgs, ... }:

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
				serif = [ "Inter" ];
				sansSerif = [ "Inter" ];
				monospace = [ "Hack Nerd Font Mono" ];
				emoji = [ "Noto Emoji" ];
			};
		};
	};
}
