{
	description = "AetherOS installer ISO with networking, LUKS, and guided setup";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
	};

	outputs = { self, nixpkgs }:
	let
		pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
		aetherLib = import ../lib nixpkgs.lib;

		aether = {
			pkgs = import ../packages { inherit pkgs aetherLib; };
			lib = aetherLib;
		};
	in
	{
		nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit aether; };
			modules = [ (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")]
			++ (aether.lib.moduleUtils.listModulesRecursively ./modules);
		};

		packages.x86_64-linux.iso = self.nixosConfigurations.installer.config.system.build.isoImage;
	};
}
