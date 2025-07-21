{
	system = { hostName, ... }:
	{
		environment.etc."aether/network/scripts".source = ./scripts;

		networking = {
			hostName = hostName;
			networkmanager.enable = true;
		};
	};
}
