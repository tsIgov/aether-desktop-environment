{ nixpkgs, home-manager, lib }: { hostName, specialArgs, systemModules, userModules }:
let
	pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
	args = specialArgs // { aetherLib = lib; };

	users = nixpkgs.lib.attrsets.mapAttrs (import ./createUserModule.nix) userModules;
	removeChannels = import ./removeChannels.nix { inherit nixpkgs; };
	setHostname = import ./setHostName.nix { inherit hostName; };
in
{
	nixosConfigurations = {
		${hostName} = nixpkgs.lib.nixosSystem {
			inherit pkgs; 
			specialArgs = args;
			modules = systemModules ++ (lib.getNixFilesRecursively ../modules/system) ++ [ 
				removeChannels
				setHostname
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						extraSpecialArgs = args;
						sharedModules = lib.getNixFilesRecursively ../modules/home;
						inherit users;
					};
				}
			]; 
		};
	};
}