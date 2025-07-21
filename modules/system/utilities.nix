{
	system = { pkgs, aether, ... }:
	{
		environment.systemPackages = with pkgs; [
			home-manager

			pciutils # CLI for controlling PCI devices
			gotop # Activity monitoring TUI
			sysstat # Performance monitoring CLI
			jq # JSON processor used in many of the aether scripts
			socat # CLI for interacting with sockets
		];
	};
}
