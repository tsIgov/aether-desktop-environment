{ config, aetherLib, pkgs, ... }:
let 
	flavorName = config.aether.appearance.flavor;
  accent = config.aether.appearance.accent;
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
      name = aetherLib.appearance.fonts.mono;
      size = 12;
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
}
