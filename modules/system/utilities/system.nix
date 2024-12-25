 { pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		pciutils
		gnome-disk-utility
		gotop
	];
}