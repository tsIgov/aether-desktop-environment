{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
      	swaylock
      	swaylock-effects
	];

	security.pam.services.swaylock = {};
}