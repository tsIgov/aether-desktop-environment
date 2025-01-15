{ home-manager, pkgs, lib }: { user, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit lib; };
in
{
	homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs; 
			extraSpecialArgs = specialArgsFinal;
			modules = [
				(import ./home.nix user)
			] ++ (lib.moduleUtils.listModulesRecursively ./modules) ++ modules;
		};
}