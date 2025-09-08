{ hostname, pkgs, ... }:
{
	environment.etc."aether/network/scripts".source = ./scripts;

	environment.systemPackages = with pkgs; [
		impala
	];

	networking = {
		hostName = hostname;
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
}
