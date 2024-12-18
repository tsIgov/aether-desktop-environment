{ config, lib, ... }:
let
	cfg = config.aether.system.users;
	usernames = builtins.attrNames cfg;
	mapUser = username: 
	{
		name = username;
		value = {
			description = cfg.${username}.description;
			extraGroups = if cfg.${username}.sudoer then [ "wheel" "networkmanager"] else [ "networkmanager" ];
			isNormalUser = !cfg.${username}.isSystemUser;
			isSystemUser = cfg.${username}.isSystemUser;
			initialPassword = cfg.${username}.initialPassword;
		};
	};
in
{
	options = with lib; with types; {
		aether.system.users = mkOption {
			type = attrsOf (submodule {
				options = with lib; with types; {

					description = mkOption {
						type = str;
						description = "A short description of the user account, typically the user's full name.";
					};

					initialPassword = mkOption {
						type = str;
						description = "Specifies the initial password for the user, i.e. the password assigned if the user does not already exist.";
					};

					isSystemUser = mkOption {
						type = bool;
						description = "Indicates if the user is a system user or not.";
					};

					sudoer = mkOption {
						type = bool;
						description = "Indicates if the user is a system has the authority to execute commands as root.";
					};
				};
			});
		};
	};

	config = {
		users.mutableUsers = true;
		users.users = builtins.listToAttrs (builtins.map mapUser usernames);
	};
}