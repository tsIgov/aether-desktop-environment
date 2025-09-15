{ pkgs, ... }:
{
	hm = {
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bindr = SUPER, SUPER_L, exec, walker
				bind = SUPER, Space, exec, elephant m aether
				bind = CTRL ALT, Delete, exec, elephant m power

				bind = SUPER, T, exec, ${pkgs.kitty}/bin/kitty
				bind = SUPER, E, exec, ${pkgs.nemo}/bin/nemo

				bind = SUPER, C, exec, pkill rofi || rofi -modes calc -theme-str 'mainbox { children: [ inputbar, message ]; }' -show
				bind = SUPER SHIFT, C, exec, hyprpicker -a
			'';
		};
	};
}
