{ pkgs, config, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str;

	cfg = config.aether.networking;
in
{
	options = {
		aether.networking = {
			hostname = mkOption { type = str; };
		};
	};

	config = {
		environment.etc."aether/network/scripts".source = ./scripts;

		environment.systemPackages = with pkgs; [
			impala
		];

		networking = {
			hostName = cfg.hostname;
			wireless.iwd.settings = {
				IPv6 = {
					Enabled = true;
				};
				Settings = {
					AutoConnect = true;
				};
			};
			wireless.iwd.enable = true;

			# networkmanager.enable = true;
		};
	};
}
