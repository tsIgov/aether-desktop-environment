{ pkgs, aether, internal, home-module }: { hostname, username, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether hostname username; };
in
{
	nixosConfigurations.aether-os = aether.inputs.nixpkgs.lib.nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal;
		modules = [
			(aether.inputs.nixpkgs.lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
			home-module {
				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = false;
				};
			}
		] ++ (aether.lib.moduleUtils.listModulesRecursively ./modules) ++ modules;
	};
}
