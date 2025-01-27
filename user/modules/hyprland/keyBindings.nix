{ ... }:

{

	wayland.windowManager.hyprland = {
		extraConfig = ''
			# Set programs that you use
			$terminal = foot
			$fileManager = nemo

			$mainMod = SUPER

			bind = $mainMod, Q, exec, $terminal
			bind = $mainMod, C, killactive, 
			bind = $mainMod, E, exec, $fileManager
			bind = $mainMod, D, togglefloating 
			bind = $mainMod, F, fullscreen, 1
			bind = SUPER, R, exec, pkill anyrun || anyrun
			bind = $mainMod, L, exec, pidof swaylock || swaylock

			bindr = SUPER, SUPER_L, exec, pkill rofi || rofi -show drun -normal-window

			# Move focus with mainMod + arrow keys
			bind = $mainMod, left, movefocus, l
			bind = $mainMod, right, movefocus, r
			bind = $mainMod, up, movefocus, u
			bind = $mainMod, down, movefocus, d


			# Move windows with mainMod + Shift + arrow keys
			bind = $mainMod SHIFT, left, movewindoworgroup, l
			bind = $mainMod SHIFT, right, movewindoworgroup, r
			bind = $mainMod SHIFT, up, movewindoworgroup, u
			bind = $mainMod SHIFT, down, movewindoworgroup, d


			# Switch workspaces with mainMod + [0-9]
			bind = $mainMod, 1, workspace, 1
			bind = $mainMod, 2, workspace, 2
			bind = $mainMod, 3, workspace, 3
			bind = $mainMod, 4, workspace, 4
			bind = $mainMod, 5, workspace, 5
			bind = $mainMod, 6, workspace, 6
			bind = $mainMod, 7, workspace, 7
			bind = $mainMod, 8, workspace, 8
			bind = $mainMod, 9, workspace, 9
			bind = $mainMod, 0, workspace, 10

			# Move active window to a workspace with mainMod + SHIFT + [0-9]
			bind = $mainMod SHIFT, 1, movetoworkspace, 1
			bind = $mainMod SHIFT, 2, movetoworkspace, 2
			bind = $mainMod SHIFT, 3, movetoworkspace, 3
			bind = $mainMod SHIFT, 4, movetoworkspace, 4
			bind = $mainMod SHIFT, 5, movetoworkspace, 5
			bind = $mainMod SHIFT, 6, movetoworkspace, 6
			bind = $mainMod SHIFT, 7, movetoworkspace, 7
			bind = $mainMod SHIFT, 8, movetoworkspace, 8
			bind = $mainMod SHIFT, 9, movetoworkspace, 9
			bind = $mainMod SHIFT, 0, movetoworkspace, 10

			# Example special workspace (scratchpad)
			bind = $mainMod, S, togglespecialworkspace, scratchpad
			bind = $mainMod SHIFT, S, movetoworkspace, special:scratchpad


			# Move/resize windows with mainMod + LMB/RMB and dragging
			bindm = $mainMod, mouse:272, movewindow
			bindm = $mainMod, mouse:273, resizewindow

			# Resize
			bind = $mainMod, M, submap, resize
			submap=resize
			binde = $mainMod, right, resizeactive, 20 0
			binde = $mainMod, left, resizeactive, -20 0
			binde = $mainMod, up, resizeactive, 0 -20
			binde = $mainMod, down, resizeactive, 0 20
			bind = $mainMod SHIFT, left, movewindow, l
			bind = $mainMod SHIFT, right, movewindow, r
			bind = $mainMod SHIFT, up, movewindow, u
			bind = $mainMod SHIFT, down, movewindow, d
			bind = , escape, submap, reset 
			submap = reset

			# Grouping
			bind = $mainMod, tab, changegroupactive, f
			bind = $mainMod SHIFT, tab, changegroupactive, b
			bind = $mainMod, G, togglegroup 
			bind = $mainMod, space, lockactivegroup, toggle
		'';
	};
}

