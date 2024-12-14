{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		aether = {
			url = "path:/home/igov/repositories/tsIgov/aether-desktop-environment";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, aether, ... }:
	let
		pkgs = aether.lib.importNixpkgs nixpkgs;
	in {
		nixosConfigurations = {
			"aether" = nixpkgs.lib.nixosSystem {
				inherit pkgs;
				specialArgs = { };
				modules = [ aether.nixosModules.system ];
			};
		};
	};
}