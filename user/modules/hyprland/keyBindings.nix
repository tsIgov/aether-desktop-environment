{ config, ... }:

{

	wayland.windowManager.hyprland = {
		extraConfig = ''
			bind = SUPER, left, movefocus, l
			bind = SUPER, right, movefocus, r
			bind = SUPER, up, movefocus, u
			bind = SUPER, down, movefocus, d

			bind = SUPER SHIFT, left, swapwindow, l
			bind = SUPER SHIFT, right, swapwindow, r
			bind = SUPER SHIFT, up, swapwindow, u
			bind = SUPER SHIFT, down, swapwindow, d

			bind = SUPER, 1, workspace, 1
			bind = SUPER, 2, workspace, 2
			bind = SUPER, 3, workspace, 3
			bind = SUPER, 4, workspace, 4
			bind = SUPER, 5, workspace, 5
			bind = SUPER, 6, workspace, 6
			bind = SUPER, 7, workspace, 7
			bind = SUPER, 8, workspace, 8
			bind = SUPER, 9, workspace, 9
			bind = SUPER, 0, workspace, 10
			

			bind = SUPER SHIFT, 1, movetoworkspace, 1
			bind = SUPER SHIFT, 2, movetoworkspace, 2
			bind = SUPER SHIFT, 3, movetoworkspace, 3
			bind = SUPER SHIFT, 4, movetoworkspace, 4
			bind = SUPER SHIFT, 5, movetoworkspace, 5
			bind = SUPER SHIFT, 6, movetoworkspace, 6
			bind = SUPER SHIFT, 7, movetoworkspace, 7
			bind = SUPER SHIFT, 8, movetoworkspace, 8
			bind = SUPER SHIFT, 9, movetoworkspace, 9
			bind = SUPER SHIFT, 0, movetoworkspace, 10

			bindr = SUPER, SUPER_L, exec, pkill anyrun || anyrun
			bind = SUPER, A, exec, pkill anyrun || anyrun
			bind = SUPER, Q, exec, ${config.aether.defaultApps.terminal}
			bind = SUPER, C, killactive, 
			bind = SUPER, E, exec, ${config.aether.defaultApps.fileManager}
			bind = SUPER, D, togglefloating 
			bind = SUPER, F, fullscreen, 1
			bind = SUPER, R, exec, pkill anyrun || anyrun
			bind = SUPER, L, exec, pidof swaylock || swaylock


			
			bind = SUPER, V, exec, pkill clipse || foot -a clipse clipse 
			bind = SUPER SHIFT, V, exec, clipse -clear
			bind = SUPER SHIFT, C, exec, hyprpicker -a 

			bind = , PRINT, exec, hyprshot -m active -m output -s -o ${config.directories.screenshot}
			bind = SUPER, PRINT, exec, hyprshot -m active -m window -s -o ${config.directories.screenshot}
			bind = SUPER SHIFT, PRINT, exec, hyprshot -m region -z -s -o ${config.directories.screenshot}



			# Example special workspace (scratchpad)
			bind = SUPER, S, togglespecialworkspace, scratchpad
			bind = SUPER SHIFT, S, movetoworkspace, special:scratchpad


			# Move/resize windows with mainMod + LMB/RMB and dragging
			bindm = SUPER, mouse:272, movewindow
			bindm = SUPER, mouse:273, resizewindow



			# Monitors
			bind = SUPER, M, submap, monitors
			submap=monitors

			bind = SUPER SHIFT, left, focusmonitor, l
			bind = SUPER SHIFT, right, focusmonitor, r
			bind = SUPER SHIFT, up, focusmonitor, u
			bind = SUPER SHIFT, down, focusmonitor, d

			bind = SUPER SHIFT, left, movecurrentworkspacetomonitor, l
			bind = SUPER SHIFT, right, movecurrentworkspacetomonitor, r
			bind = SUPER SHIFT, up, movecurrentworkspacetomonitor, u
			bind = SUPER SHIFT, down, movecurrentworkspacetomonitor, d
			bind = , escape, submap, reset 
			submap = reset
		'';
	};
}

