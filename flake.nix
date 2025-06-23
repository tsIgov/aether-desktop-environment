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

		aether = {
			lib = aetherLib;
			pkgs = import ./packages { inherit pkgs aetherLib; };
			inputs = inputs;
		};
	in
	{
		lib = aetherLib;
		systemConfig = import ./system.nix { inherit aether pkgs internal; };
		userConfig = import ./home.nix { inherit aether pkgs internal; };
	};
}
