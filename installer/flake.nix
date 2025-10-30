{
	description = "AetherOS installer ISO with networking, LUKS, and guided setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
	let
		pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
		aetherLib = import ../lib inputs.nixpkgs.lib;

		aether = {
			pkgs = import ../packages { inherit pkgs aetherLib; };
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

		iso-module = (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix");

		installer = inputs.nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit aether; };
			modules = [
				home-module
				iso-module
			] ++ (aether.lib.moduleUtils.listModulesRecursively ./modules);
		};
	in
	{
		nixosConfigurations.installer = installer;
		packages.x86_64-linux.iso = installer.config.system.build.isoImage;
	};
}
