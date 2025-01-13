{
  description = "Aether desktop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = { nixpkgs, home-manager, ... }: 
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    utils = import ./utilities/internal.nix { inherit nixpkgs; }; 
  in 
  {
    systemConfig = import ./system { inherit nixpkgs pkgs utils; };
    userConfig = import ./user { inherit home-manager pkgs utils; };
  };
}
