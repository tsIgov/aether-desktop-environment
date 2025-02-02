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
		anyrun = {
			url = "github:anyrun-org/anyrun";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs: 
	let
		pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
		aetherLib = import ./lib inputs.nixpkgs.lib;

		aether = {
			lib = aetherLib;
			pkgs = import ./packages { inherit pkgs aetherLib; };
			inputs = inputs;
		};
	in 
	{
		lib = aetherLib;
		systemConfig = import ./system { inherit aether pkgs; };
		userConfig = import ./user { inherit aether pkgs; };
	};
}
