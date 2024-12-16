{ pkgs, config, ... }:

{
	wayland.windowManager.hyprland = {
		extraConfig = ''
			bind = , PRINT, exec, hyprshot -m output -s -o ${config.directories.screenshot}
			bind = SUPER, PRINT, exec, hyprshot -m window -s -o ${config.directories.screenshot}
			bind = SUPER SHIFT, PRINT, exec, hyprshot -m region -z -s -o ${config.directories.screenshot}
		'';
	};
}
