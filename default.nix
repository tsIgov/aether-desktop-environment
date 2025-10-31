{ pkgs, aether, home-module }: { specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether; };

	inherit (aether.lib.moduleUtils) listModulesRecursively;
	inherit (aether.inputs.nixpkgs.lib) nixosSystem;
in
{
	nixosConfigurations.aether-os = nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal;
		modules = [
			home-module
		] ++ (listModulesRecursively ./modules) ++ modules;
	};
}
