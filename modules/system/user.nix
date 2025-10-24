{ lib, config, pkgs, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) listOf str;

	cfg = config.aether.user;
in
{
	options = {
		aether.user = {
			username = mkOption { type = str; };
			description = mkOption { type = str; };
			extraGroups = mkOption { type = listOf str; default = []; };
		};
	};

	config = {
		users = {
			mutableUsers = true;
			users.${cfg.username} = {
				description = cfg.description;
				extraGroups = [ "wheel" "networkmanager" ] ++ cfg.extraGroups;
				isNormalUser = true;
				isSystemUser = false;
				shell = pkgs.fish;
			};
		};
	};
}
