{ home-manager, pkgs, aetherLib, aetherPkgs }: { user, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aetherLib aetherPkgs; };
in
{
	homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs; 
			extraSpecialArgs = specialArgsFinal;
			modules = [
				(import ./home.nix user)
			] ++ (aetherLib.moduleUtils.listModulesRecursively ./modules) ++ modules;
		};
}