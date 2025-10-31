{ pkgs, lib, aetherPkgs, aetherLib }:
rec {
	catppuccin = import ./catppuccin.nix {inherit pkgs lib aetherPkgs aetherLib; };
}
