{ aether, pkgs, internal }: { username, specialArgs ? {}, modules ? [] }:
let
	specialArgsFinal = specialArgs // { inherit aether username; };
in
{
	homeConfigurations.${username} = aether.inputs.home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = specialArgsFinal;
			modules = (internal.getModules ./modules "home") ++ modules;
		};
}
