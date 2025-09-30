{ ... }:
{
	services = {
		logind.lidSwitch = "ignore";
		upower.enable = true;

		auto-cpufreq = {
			enable = true;
			settings = {
				charger = {
					governor = "performance";
					turbo = "auto";
				};

				battery = {
					governor = "powersave";
					turbo = "auto";
				};
			};
		};
	};

	security.sudo.extraConfig = ''
		%wheel ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/auto-cpufreq
	'';
}
