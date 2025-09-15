{ config, ... }:
{
	hm = {
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bindr = SUPER, SUPER_L, exec, walker
				bind = SUPER, Space, exec, elephant m aether
				bind = SUPER, T, exec, ${config.aether.applications.default-apps.terminal}
				bind = SUPER, E, exec, ${config.aether.applications.default-apps.fileManager}

				bind = SUPER, C, exec, pkill rofi || rofi -modes calc -theme-str 'mainbox { children: [ inputbar, message ]; }' -show
				bind = SUPER SHIFT, C, exec, hyprpicker -a
			'';
		};
	};
}
