{ pkgs, config, ... }:
let 
	colorVariant = config.system.appearance.colorVariant;
in
{
  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = colorVariant;
      font  = "Inter";
      fontSize = "12";
      #background = "${./wallpaper.png}";
      #loginBackground = false;
    })
  ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "catppuccin-${colorVariant}";
    wayland = {
      enable = true;
    };
  };
}