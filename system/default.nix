{ nixpkgs, pkgs, lib }: { hostName, specialArgs ? {}, modules ? [] }:
{
	nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
		inherit pkgs specialArgs; 
		modules = [ 
			./system.nix
			(import ./removeChannels.nix nixpkgs)
			(args: { networking.hostName = hostName; })
		] ++ (lib.getNixFilesRecursively ./modules) ++ modules; 
	};
}