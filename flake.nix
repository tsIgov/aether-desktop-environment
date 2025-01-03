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
    lib = import ./utilities/lib.nix { inherit nixpkgs; }; 
    createSystem = import ./utilities/createSystem.nix { inherit nixpkgs home-manager lib; };
  in 
  {
    inherit createSystem lib;
  };
}
