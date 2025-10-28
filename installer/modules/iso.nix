{ lib, ... }:
{
	isoImage = {
		isoBaseName = lib.mkForce "aether-os-installer";
		appendToMenuLabel = "AetherOS Installer";
	};
}
