{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-macchiato-mauve-standard+normal";
      #package = import ../../../../derivations/gtk-theme/default.nix { inherit pkgs; };
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "macchiato";
      };
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
}
