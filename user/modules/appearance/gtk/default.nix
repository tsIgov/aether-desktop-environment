{ config, lib, pkgs, ... }:
let 
	variant = config.aether.appearance.variant;
  accent = config.aether.appearance.accent;
	colors = lib.colors.${variant};
in
{
  gtk = {
    enable = true;

    theme = {
      name = "catppuccin-${variant}-${accent}-standard+normal";
      package = pkgs.catppuccin-gtk.override {
        accents = [ accent ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = variant;
      };
    };

    font = {
      name = "Hack Nerd Font Mono";
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
}
