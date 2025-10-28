{ lib, ... }:
{
	networking = {
		hostName = "aether-os";
		networkmanager.enable = true;
		wireless.enable = lib.mkForce false;
	};
}
