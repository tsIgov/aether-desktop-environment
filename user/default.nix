{ aether, pkgs, internal }: { user, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether; };
in
{
	homeConfigurations.${user} = aether.inputs.home-manager.lib.homeManagerConfiguration {
			inherit pkgs; 
			extraSpecialArgs = specialArgsFinal;
			modules = [
				(import ./home.nix user)
			] ++ (aether.lib.moduleUtils.listModulesRecursively ./modules) ++ modules ++ 
			(internal.getModules ../modules "home");
		};
}