{ pkgs, ... }:

{
  	services.gnome.gnome-keyring.enable = true;
	security.pam.services.tuigreet.enableGnomeKeyring = true;

	environment.systemPackages = with pkgs; [
      	seahorse
	];
}