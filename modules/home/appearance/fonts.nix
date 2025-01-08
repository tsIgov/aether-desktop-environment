{ config, pkgs, lib, ... }:

{
	options = with lib; with types; {
		appearance.fontSize = mkOption { type = int; default = 12; };
	};

  config = {

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Inter" ];
				sansSerif = [ "Inter" ];
				monospace = [ "Hack Nerd Font Mono" ];
				emoji = [ "Noto Emoji" ];
      };
    };

    gtk.font = {
      name = "Inter";
      size = config.appearance.fontSize;
    };
    
  };
}
