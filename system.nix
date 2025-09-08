{ pkgs, aether, internal, home-module }: { hostname, username, specialArgs ? {}, modules ? [], homeModules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether hostname username; };
in
{
	nixosConfigurations.${hostname} = aether.inputs.nixpkgs.lib.nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal;
		modules = (internal.getModules ./modules "system")  ++ modules ++ [
			home-module {
				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = false;
					extraSpecialArgs = specialArgsFinal;
					users.${username} = { ... } :
					{
						imports = (internal.getModules ./modules "home") ++ homeModules;
					};
				};
			}
		];
	};
}
