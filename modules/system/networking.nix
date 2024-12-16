{ config, lib, pkgs, ... }:
let
	cfg = config.aether.system.networking;
in
{
	options = with lib; with types; {
		aether.system.networking = {
			hostname = mkOption { type = types.strMatching "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
      		description = ''
				The name of the machine. Leave it empty if you want to obtain it from a
				DHCP server (if using DHCP). The hostname must be a valid DNS label (see
				RFC 1035 section 2.3.1: "Preferred name syntax", RFC 1123 section 2.1:
				"Host Names and Numbers") and as such must not contain the domain part.
				This means that the hostname must start with a letter or digit,
				end with a letter or digit, and have as interior characters only
				letters, digits, and hyphen. The maximum length is 63 characters.
				Additionally it is recommended to only use lower-case characters.
			''; 
			};
		};
	};

	config = {
		environment.systemPackages = with pkgs; [
			networkmanagerapplet
		];

		networking.networkmanager.enable = true;
		networking.hostName = cfg.hostname;

		programs.nm-applet.enable = true;
	};
}
