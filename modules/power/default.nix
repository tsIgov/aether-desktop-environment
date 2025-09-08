{ ... }:
{
	environment.etc."aether/power/scripts".source = ./scripts;

	services = {
		logind.lidSwitch = "ignore";
		upower.enable = true;
		power-profiles-daemon.enable = true;
	};

	hm = {
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = CTRL ALT, Delete, exec, sh /etc/aether/power/scripts/power-menu.sh
			'';
		};
	};
}
