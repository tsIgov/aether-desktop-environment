{ ... }:
{
	services = {
		logind.lidSwitch = "ignore";
		upower.enable = true;
		power-profiles-daemon.enable = true;
	};
}
