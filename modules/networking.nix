{
	system = { hostName, ... }:
	{
		networking = {
			hostName = hostName;
			networkmanager.enable = true;
		};
	};
}