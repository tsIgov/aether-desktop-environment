{ config, pkgs, lib, ... }:

let
  cfg = config.user;
in
{
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Inter" ];
				sansSerif = [ "Inter" ];
				monospace = [ "Hack Nerd Font Mono" ];
				emoji = [ "Noto Emoji" ];
      };
    };

}
