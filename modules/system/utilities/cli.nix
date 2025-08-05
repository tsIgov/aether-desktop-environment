{
	system = { pkgs, aether, ... }:
	{
		environment.systemPackages = with pkgs; [
			pciutils # CLI for controlling PCI devices
			sysstat # Performance monitoring CLI
			jq # JSON processor used in many of the aether scripts
			socat # CLI for interacting with sockets
		];
	};
}
