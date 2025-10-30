{ lib, ... }:
{
	isoImage = {
		isoBaseName = lib.mkForce "aether-os-installer";
		appendToMenuLabel = "AetherOS Installer";
	};

	boot.loader.timeout = lib.mkForce 0;
	networking.wireless.enable = lib.mkForce false;
}
