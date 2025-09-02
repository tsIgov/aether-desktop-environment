{
	home = { config, ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bindr = SUPER, SUPER_L, exec, pkill rofi || rofi -show
				bind = SUPER, T, exec, ${config.aether.applications.default-apps.terminal}
				bind = SUPER, E, exec, ${config.aether.applications.default-apps.fileManager}

				bind = SUPER, C, exec, pkill rofi || rofi -modes calc -theme-str 'mainbox { children: [ inputbar, message ]; }' -show
				bind = SUPER SHIFT, C, exec, hyprpicker -a
			'';
		};
	};
}
