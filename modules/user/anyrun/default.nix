{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    anyrun
  ];

  home.file = {
    ".config/anyrun/config.ron".source = ./config.ron;
  };
}



