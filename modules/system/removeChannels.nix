{ pkgs, aether, ... }:
let
	nixpkgs = aether.inputs.nixpkgs;
in
{
	nix.channel.enable = false;
	nix.registry.nixpkgs.flake = nixpkgs;
	environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
	# https://github.com/NixOS/nix/issues/9574
	nix.settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
}
