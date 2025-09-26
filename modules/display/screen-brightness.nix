{ pkgs, config, lib, ... }:
{
	environment.systemPackages = with pkgs; [
		brightnessctl # controls display brightness
	];
}
