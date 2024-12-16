{ config, pkgs, lib, ... }:

{
	options = with lib; with types; {
		appearance.fonts = {
			propo-name = mkOption { type = str; description = "The name of the proportional font variant"; };
			mono-name = mkOption { type = str; description = "The name of the monospace font variant"; };
      default-name = mkOption { type = str; description = "The default font name to use"; };
			default-size = mkOption { type = int; description = "The default font size"; };
		};
	};

  config = {

    home.packages = with pkgs; [
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ config.appearance.fonts.mono-name ];
        sansSerif = [ config.appearance.fonts.propo-name ];
        serif = [ config.appearance.fonts.propo-name ];
      };
    };

    gtk.font = {
      package = pkgs.nerd-fonts.ubuntu;
      name = config.appearance.fonts.default-name;
      size = config.appearance.fonts.default-size;
    };
  };
}
