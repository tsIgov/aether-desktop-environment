{ config, ... }:

{
	wayland.windowManager.hyprland = {
		settings = {
			exec-once = [
				"clipse -listen" # run listener on startup
			];

			windowrulev2 = [
				"float,class:(clipse)" # ensure you have a floating window class set if you want this behavior
				"size 622 652,class:(clipse)" # set the size of the window as necessary
			];
		};

		extraConfig = ''
			bind = SUPER, V, exec, pkill clipse || foot -a clipse clipse 
			bind = SUPER SHIFT, V, exec, clipse -clear
		'';
	};
}

