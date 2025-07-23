{
	home = { config, ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = SUPER, N, exec, pkill rofi || rofi -show
				bind = SUPER, T, exec, ${config.aether.applications.default-apps.terminal}
				bind = SUPER, E, exec, ${config.aether.applications.default-apps.fileManager}

				bind = SUPER SHIFT, C, exec, hyprpicker -a
			'';
		};
	};
}
