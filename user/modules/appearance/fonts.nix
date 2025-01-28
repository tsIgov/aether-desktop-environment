{ config, aether, ... }:

let
  cfg = config.user;
in
{
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ aether.lib.appearance.fonts.regular ];
				sansSerif = [ aether.lib.appearance.fonts.regular ];
				monospace = [ aether.lib.appearance.fonts.mono ];
				emoji = [ aether.lib.appearance.fonts.emoji ];
      };
    };

}
