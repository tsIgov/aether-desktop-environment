{ config, ... }:

{
	wayland.windowManager.hyprland = {
		extraConfig = ''
			bind = SUPER SHIFT, C, exec, hyprpicker -a 
		'';
	};
}

