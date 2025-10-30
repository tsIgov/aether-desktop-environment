{ aether, lib, ... }:
{
	environment.systemPackages = [
		aether.pkgs.aether-install
	];

	programs.fish.shellInit = ''aether-install'';
}
