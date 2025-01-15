{ nixpkgs, pkgs, lib }: { hostName, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit lib; };
in
{
	nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
		inherit pkgs;
		specialArgs = specialArgsFinal; 
		modules = [ 
			./system.nix
			(import ./removeChannels.nix nixpkgs)
			(args: { networking.hostName = hostName; })
		] ++ (lib.moduleUtils.listModulesRecursively ./modules) ++ modules; 
	};
}