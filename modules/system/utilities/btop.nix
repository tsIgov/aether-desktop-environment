{ pkgs, aether, config, ... }:
{
	environment.systemPackages = with pkgs; [
		btop # Activity monitoring TUI
	];
	hm = {
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = SUPER SHIFT, Escape, exec, kitty --class btop btop
			'';

			settings = {
				windowrulev2 = [
					"float, class:(btop)"
					"center 1, class:(btop)"
					"size 50% 50%, class:(btop)"
				];
			};
		};
	};
}
