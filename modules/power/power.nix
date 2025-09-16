{ ... }:
{
	environment.etc."aether/power/scripts".source = ./scripts;

	services = {
		logind.lidSwitch = "ignore";
		upower.enable = true;
		power-profiles-daemon.enable = true;
	};
}
