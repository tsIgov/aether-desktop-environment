{
	system = { pkgs, aether, ... }:
	{
		system.stateVersion = "24.11";
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		environment.systemPackages = with pkgs; [
			# home-manager
		];

		home-manager.users.igov.home.file."test.test".text = ''test'';

		programs.nix-ld.enable = true; # Allows dynamic linking
	};

	home = { username, ... }:
	{
		programs.home-manager.enable = true;
		news.display = "silent";

		home = {
			username = username;
			homeDirectory = "/home/${username}";
			stateVersion = "24.05";
		};
	};
}
