{
	home = { config, aether, pkgs, ... }:
	{

		wayland.windowManager.hyprland = {
			extraConfig = ''

				bind = SUPER, J,exec,pypr toggle term
				bind = SUPER, K, exec, pypr toggle_special quick

				bind = SUPER, d, movefocus, r
				bind = SUPER, a, movefocus, l
				bind = SUPER, w, movefocus, u
				bind = SUPER, s, movefocus, d

				bind = SUPER SHIFT, a, movewindow, l
				bind = SUPER SHIFT, d, movewindow, r
				bind = SUPER SHIFT, w, movewindow, u
				bind = SUPER SHIFT, s, movewindow, d

				bind = SUPER, 1, workspace, 1
				bind = SUPER, 2, workspace, 2
				bind = SUPER, 3, workspace, 3
				bind = SUPER, 4, workspace, 4
				bind = SUPER, 5, workspace, 5

				bind = SUPER SHIFT, 1, movetoworkspace, 1
				bind = SUPER SHIFT, 2, movetoworkspace, 2
				bind = SUPER SHIFT, 3, movetoworkspace, 3
				bind = SUPER SHIFT, 4, movetoworkspace, 4
				bind = SUPER SHIFT, 5, movetoworkspace, 5

				bind = SUPER, Q, exec, sh $HOME/.config/hypr/scripts/quick.sh
				bind = SUPER SHIFT, Q, exec, sh $HOME/.config/hypr/scripts/move.sh


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
				submap = reset


				# Resizing
				bind = SUPER, r, submap, resize
				submap = resize
				bind = SUPER, d, scroller:cyclewidth, next
				bind = SUPER, a, scroller:cyclewidth, prev
				bind = SUPER, s, scroller:cycleheight, next
				bind = SUPER, w, scroller:cycleheight, prev
				bind = , escape, submap, reset
				submap = reset

				bind = SUPER, g, scroller:admitwindow,
				bind = SUPER SHIFT, g, scroller:expelwindow,

				bind = SUPER, F, scroller:toggleoverview
				bind = SUPER SHIFT, F, scroller:fitsize, all

				bind = SUPER, N, exec, walker
				bind = SUPER, T, exec, ${config.aether.defaultApps.terminal}
				bind = SUPER, E, exec, ${config.aether.defaultApps.fileManager}

				bind = ALT, F4, killactive
				bind = SUPER, C, killactive
				bind = , PRINT, exec, walker -m screenshot
				bind = SUPER, L, exec, pidof swaylock || swaylock
				bind = CTRL ALT, Delete, exec, walker -m power

				bind = SUPER, V, exec, pkill clipse || kitty --class clipse clipse
				bind = SUPER SHIFT, V, exec, clipse -clear
				bind = SUPER SHIFT, C, exec, hyprpicker -a













				# Move/resize windows with mainMod + LMB/RMB and dragging
				# bindm = SUPER, mouse:272, movewindow
				# bindm = SUPER, mouse:273, resizewindow

				bindle=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ -l 1.0
				bindle=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
				bindle=, XF86MonBrightnessUp, exec, brightnessctl s +1
				bindle=, XF86MonBrightnessDown, exec, brightnessctl s -1
				bindle=, XF86Search, exec, walker
				bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
				bindl=, XF86AudioPlay, exec, playerctl play-pause
				bindl=, XF86AudioStop, exec, playerctl stop
				bindl=, XF86AudioNext, exec, playerctl next
				bindl=, XF86AudioPrev, exec, playerctl previous
			'';
		};
	};
}
