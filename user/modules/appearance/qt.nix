{ config, pkgs, ... }:

let 
	variant = config.aether.appearance.variant;
  accent = config.aether.appearance.accent;
in
{
  home.packages = with pkgs; [
    qt5.qtwayland
		qt6.qtwayland
    kdePackages.qtstyleplugin-kvantum
  ];


  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
       package = pkgs.catppuccin-kvantum.override {
         accent =  accent;
         variant = variant;
       };
   };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "catppuccin-${variant}-${accent}";
  };
}
