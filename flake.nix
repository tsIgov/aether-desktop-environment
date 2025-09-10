{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		walker.url = "github:abenz1267/walker";
	};

	outputs = inputs:
	let
		pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
		aetherLib = import ./lib inputs.nixpkgs.lib;
		internal = import ./internal aetherLib;

		aether = {
			pkgs = import ./packages { inherit pkgs aetherLib; };
			lib = aetherLib;
			inputs = inputs;
		};

		home-module = { ... }: {
			imports = [ inputs.home-manager.nixosModules.home-manager ];
			home-manager = {
				useGlobalPkgs = true;
				useUserPackages = false;
			};
		};
	in
	{
		lib = aetherLib;
		aetherConfig = import ./default.nix { inherit aether pkgs internal home-module; };
	};
}
