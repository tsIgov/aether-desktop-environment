{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
	let
		pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
		aetherLib = import ./lib inputs.nixpkgs.lib;
		internal = import ./internal aetherLib;
		home-module = inputs.home-manager.nixosModules.home-manager;

		aether = {
			lib = aetherLib;
			pkgs = import ./packages { inherit pkgs aetherLib; };
			inputs = inputs;
		};
	in
	{
		lib = aetherLib;
		aetherConfig = import ./system.nix { inherit aether pkgs internal home-module; };
	};
}
