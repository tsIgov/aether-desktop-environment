{ packages, ...}: { config, lib, ... }:
{
	environment.systemPackages = with packages; [
		htop
	];
}