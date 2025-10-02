{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		qalculate-gtk
	];

	hm = {
		wayland.windowManager.hyprland = {
			settings = {
				windowrulev2 = [
					"float, class:(qalculate-gtk)"
					"center 1, class:(qalculate-gtk)"
					"size 700 500, class:(qalculate-gtk)"
				];
			};
		};
	};
}
