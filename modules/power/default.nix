{
	system = { ... }:
	{
		environment.etc."aether/power/scripts".source = ./scripts;

		services = {
			upower.enable = true;
			power-profiles-daemon.enable = true;
		};
	};

	home = { ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = CTRL ALT, Delete, exec, sh /etc/aether/power/scripts/power-menu.sh
			'';
		};
	};
}
