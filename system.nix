{ pkgs, aether, internal, home-module }: { hostname, username, specialArgs ? {}, modules ? [], homeModules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether hostname username; };
in
{
	nixosConfigurations.${hostname} = aether.inputs.nixpkgs.lib.nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal;
		modules = (aether.lib.moduleUtils.listModulesRecursively ./modules)  ++ modules ++ [
			(aether.inputs.nixpkgs.lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
			home-module {
				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = false;
					extraSpecialArgs = specialArgsFinal;
				};
			}
		];
	};
}
