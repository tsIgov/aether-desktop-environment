{
  description = "Aether desktop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprpanel, ... }: 
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    aetherLib = import ./lib nixpkgs.lib;
    aetherPkgs = import ./packages { inherit pkgs aetherLib; };
  in 
  {
    lib = aetherLib;
    systemConfig = import ./system { inherit nixpkgs pkgs aetherLib aetherPkgs; };
    userConfig = import ./user { inherit home-manager pkgs aetherLib aetherPkgs hyprpanel; };
  };
}
