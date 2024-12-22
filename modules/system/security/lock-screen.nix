{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
      	swaylock-effects
	];

	security.pam.services.swaylock = {};
}