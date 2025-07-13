{
	system = { ... }:
	{
		environment.etc."aether/boot/scripts".source = ./scripts;
	};

	home = { ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = CTRL ALT, Delete, exec, sh /etc/aether/boot/scripts/power-menu.sh
			'';
		};
	};
}
