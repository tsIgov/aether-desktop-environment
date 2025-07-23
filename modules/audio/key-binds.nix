{
	home = { config, aether, pkgs, ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
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
