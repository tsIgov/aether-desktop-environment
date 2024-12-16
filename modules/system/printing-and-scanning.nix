 { pkgs, ... }:

{
	services.printing.enable = true;
	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

	hardware.sane.enable = true;

	environment.systemPackages = with pkgs; [
		system-config-printer
		simple-scan
	];
}