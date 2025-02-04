{ pkgs, aether, internal }: { hostName, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether hostName; };
in
{
	nixosConfigurations.${hostName} = aether.inputs.nixpkgs.lib.nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal; 
		modules = (internal.getModules ./modules "system") ++ modules; 
	};
}