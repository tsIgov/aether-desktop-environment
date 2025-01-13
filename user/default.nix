{ home-manager, pkgs, utils }: { user, specialArgs ? {}, modules ? [] }:
{
	homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs; 
			extraSpecialArgs = specialArgs;
			modules = [
				(import ./home.nix user)
			] ++ (utils.getNixFilesRecursively ./modules) ++ modules;
		};
}