{ pkgs, aether, internal, home-module }: { hostname, username, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether hostname username; };

	inherit (aether.inputs.nixpkgs.lib) nixosSystem mkAliasOptionModule;
	inherit (aether.lib.moduleUtils) listModulesRecursively;
in
{
	nixosConfigurations.aether-os = nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal;
		modules = [
			(mkAliasOptionModule ["hm"] ["home-manager" "users" username])
			home-module
		] ++ (listModulesRecursively ./modules) ++ modules;
	};
}
