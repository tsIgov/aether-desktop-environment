{ pkgs, username, ... }:
{
	system.stateVersion = "24.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	programs.nix-ld.enable = true; # Allows dynamic linking

	hm = {
		programs.home-manager.enable = true;
		news.display = "silent";

		home = {
			username = username;
			homeDirectory = "/home/${username}";
			stateVersion = "24.05";
		};
	};
}
