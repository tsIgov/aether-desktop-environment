{
	system = { pkgs, ... }:
	{
		services.printing = {
			enable = true;
			drivers = with pkgs; [ gutenprint cups-filters hplipWithPlugin ];
			browsing = true;
			browsedConf = ''
				BrowseDNSSDSubTypes _cups,_print
				BrowseLocalProtocols all
				BrowseRemoteProtocols all
				CreateIPPPrinterQueues All

				BrowseProtocols all
			'';
		};
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
	};
}