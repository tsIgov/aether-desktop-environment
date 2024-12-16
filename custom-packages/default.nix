{ pkgs, ... }:

{
  gtk-theme = import ./gtk-theme/default.nix { inherit pkgs; };
}