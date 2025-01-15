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
    lib = nixpkgs.lib.extend (final: prev: (import ./lib final));

    utils = import ./utilities/internal.nix { inherit nixpkgs; }; 
  in 
  {
    inherit lib;

    systemConfig = import ./system { inherit nixpkgs pkgs lib; };
    userConfig = import ./user { inherit home-manager pkgs lib; };
  };
}
