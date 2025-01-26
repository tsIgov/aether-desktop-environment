{ config, aetherLib, ... }:

let
  cfg = config.user;
in
{
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ aetherLib.appearance.fonts.regular ];
				sansSerif = [ aetherLib.appearance.fonts.regular ];
				monospace = [ aetherLib.appearance.fonts.mono ];
				emoji = [ aetherLib.appearance.fonts.emoji ];
      };
    };

}
