{ pkgs, ... }:
{
	boot = {
		initrd.verbose = false;
		plymouth = {
			enable = true;
			theme =  "bgrt";
			logo = ../../logos/logo-64x64.png;
		};
	};
}
