{ config, custom-pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Igov-GTK";
      package = custom-pkgs.gtk-theme;
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
