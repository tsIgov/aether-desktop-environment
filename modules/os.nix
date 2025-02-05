{
	system = { pkgs, aether, ... }:
	let
    	nixpkgs = aether.inputs.nixpkgs;
	in
	{
		system.stateVersion = "24.11";
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		environment.systemPackages = with pkgs; [
			home-manager
		];

		nix.channel.enable = false;
		nix.registry.nixpkgs.flake = nixpkgs;
		environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
		# https://github.com/NixOS/nix/issues/9574
		nix.settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
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
