{ config, pkgs, ... }:

{
  # home.packages = with pkgs; [
  #   adwaita-qt
  #   qt5.qtwayland
	# 	qt6.qtwayland
	# 	qt5ct

  #   kdePackages.qtstyleplugin-kvantum
  #   #kdePackages.dolphin
  #   kdePackages.kate
  # ];

  # home.file.".config/qt5ct" = {
  #   source = ./config;
  #   recursive = true;
  # };

  # home.sessionVariables = {
  #     QT_QPA_PLATFORMTHEME = "qt5ct";
  #   };
}
