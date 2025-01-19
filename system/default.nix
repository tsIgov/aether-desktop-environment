{ nixpkgs, pkgs, aetherLib, aetherPkgs }: { hostName, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aetherLib aetherPkgs; };
in
{
	nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal; 
		modules = [ 
			./system.nix
			(import ./removeChannels.nix nixpkgs)
			(args: { networking.hostName = hostName; })
		] ++ (aetherLib.moduleUtils.listModulesRecursively ./modules) ++ modules; 
	};
}