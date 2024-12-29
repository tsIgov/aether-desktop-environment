{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    vivaldi
    floorp
    tor-browser
    firefox
  ];
}
