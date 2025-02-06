{

	system = { pkgs, ... }:
	{
		services.gnome.gnome-keyring.enable = true;
		security.pam.services.sddm.enableGnomeKeyring = true;
	};

	home = { pkgs, ... }:
	{
		home.packages = with pkgs; [
			seahorse
		];
	};

}