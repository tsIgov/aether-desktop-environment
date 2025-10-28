{ lib, ... }:
{
	boot = {
		loader = {
			timeout = lib.mkForce 0;
			systemd-boot = {
				enable = true;
				editor = false;
			};

			efi.canTouchEfiVariables = true;
		};

		initrd.verbose = false;

		plymouth = {
			enable = true;
			theme =  "bgrt";
			logo = ../../logos/logo-64x64.png;
		};
	};
}
