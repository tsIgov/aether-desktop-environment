{ pkgs, aether }: { hostName, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether; };
in
{
	nixosConfigurations.${hostName} = aether.inputs.nixpkgs.lib.nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal; 
		modules = [ 
			./system.nix
			(import ./removeChannels.nix aether.inputs.nixpkgs)
			(args: { networking.hostName = hostName; })
		] ++ (aether.lib.moduleUtils.listModulesRecursively ./modules) ++ modules; 
	};
}