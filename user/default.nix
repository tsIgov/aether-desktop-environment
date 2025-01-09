{ home-manager, pkgs, lib }: { user, specialArgs ? {}, modules ? [] }:
{
	homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs; 
			extraSpecialArgs = specialArgs;
			modules = [
				(import ./home.nix user)
			] ++ (lib.getNixFilesRecursively ./modules) ++ modules;
		};
}