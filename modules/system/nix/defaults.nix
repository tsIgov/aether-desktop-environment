 { pkgs, ... }:

{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "24.11"; 

	environment.systemPackages = with pkgs; [
		home-manager
	];
}