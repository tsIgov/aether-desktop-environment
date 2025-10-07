{ pkgs, aether, ... }:
{
	environment.systemPackages = with pkgs; [
		fastfetch # CLI for showing system information
	];

	hm = {
		home.file = {
			".config/fastfetch/config.jsonc".source = ./config.jsonc;
			".config/fastfetch/logo.txt".source = ../../../../logos/logo-ascii.txt;
		};
	};
}
