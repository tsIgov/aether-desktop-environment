{ ... }:
{
	hm = {
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = SUPER, d, movefocus, r
				bind = SUPER, a, movefocus, l
				bind = SUPER, w, movefocus, u
				bind = SUPER, s, movefocus, d

				binde = SUPER SHIFT, a, exec, sh /etc/aether/window-manager/scripts/move.sh l
				binde = SUPER SHIFT, d, exec, sh /etc/aether/window-manager/scripts/move.sh r
				binde = SUPER SHIFT, w, exec, sh /etc/aether/window-manager/scripts/move.sh u
				binde = SUPER SHIFT, s, exec, sh /etc/aether/window-manager/scripts/move.sh d

				bind = SUPER, 1, exec, sh /etc/aether/window-manager/scripts/change-workspace.sh 1
				bind = SUPER, 2, exec, sh /etc/aether/window-manager/scripts/change-workspace.sh 2
				bind = SUPER, 3, exec, sh /etc/aether/window-manager/scripts/change-workspace.sh 3
				bind = SUPER, 4, exec, sh /etc/aether/window-manager/scripts/change-workspace.sh 4
				bind = SUPER, 5, exec, sh /etc/aether/window-manager/scripts/change-workspace.sh 5

				bind = SUPER SHIFT, 1, movetoworkspace, 1
				bind = SUPER SHIFT, 2, movetoworkspace, 2
				bind = SUPER SHIFT, 3, movetoworkspace, 3
				bind = SUPER SHIFT, 4, movetoworkspace, 4
				bind = SUPER SHIFT, 5, movetoworkspace, 5

				bind = SUPER, Q, exec, sh /etc/aether/window-manager/scripts/quick-toggle.sh
				bind = SUPER SHIFT, Q, exec, sh /etc/aether/window-manager/scripts/quick-move.sh


				# Monitors
				bind = SUPER, M, submap, monitors
				submap = monitors
				bind = SUPER, a, focusmonitor, l
				bind = SUPER, d, focusmonitor, r
				bind = SUPER, w, focusmonitor, u
				bind = SUPER, s, focusmonitor, d
				bind = SUPER SHIFT, a, movecurrentworkspacetomonitor, l
				bind = SUPER SHIFT, d, movecurrentworkspacetomonitor, r
				bind = SUPER SHIFT, w, movecurrentworkspacetomonitor, u
				bind = SUPER SHIFT, s, movecurrentworkspacetomonitor, d
				bind = , escape, submap, reset
				bind = , catchall, submap, monitors
				bind = SUPER, catchall, submap, monitors
				submap = reset


				# Resizing
				bind = SUPER SHIFT, r, submap, resize
				submap = resize
				binde = SUPER SHIFT, d, exec, sh /etc/aether/window-manager/scripts/resize.sh r
				binde = SUPER SHIFT, a, exec, sh /etc/aether/window-manager/scripts/resize.sh l
				binde = SUPER SHIFT, s, exec, sh /etc/aether/window-manager/scripts/resize.sh d
				binde = SUPER SHIFT, w, exec, sh /etc/aether/window-manager/scripts/resize.sh u
				bind = SUPER, d, movefocus, r
				bind = SUPER, a, movefocus, l
				bind = SUPER, w, movefocus, u
				bind = SUPER, s, movefocus, d
				bindm = SUPER, mouse:272, movewindow
				bindm = SUPER, mouse:273, resizewindow
				bind = , escape, submap, reset
				bind = , catchall, submap, resize
				bind = SUPER, catchall, submap, resize
				submap = reset

				# Move/resize windows with mainMod + LMB/RMB and dragging
				bindm = SUPER, mouse:272, movewindow
				bindm = SUPER, mouse:273, resizewindow

				# Grouping
				bind = SUPER, g, exec, sh /etc/aether/window-manager/scripts/group.sh
				bind = SUPER SHIFT, g, exec, sh /etc/aether/window-manager/scripts/master.sh
				bind = SUPER, tab, changegroupactive, f
				bind = SUPER SHIFT, tab, changegroupactive, b





				bind = SUPER, H, exec, sh /etc/aether/window-manager/scripts/toggle-floating-focus.sh
				bind = SUPER SHIFT, H, togglefloating
				bind = SUPER SHIFT, H, centerwindow, 1

				bind = SUPER, F, fullscreen, 1
				bind = SUPER SHIFT, F, fullscreen, 0


				bind = ALT, F4, killactive
				bind = SUPER, F4, killactive

				bind = SUPER SHIFT, X, exec, hyprctl kill
			'';
		};
	};
}
