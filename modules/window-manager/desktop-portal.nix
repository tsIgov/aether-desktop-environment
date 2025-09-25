{ pkgs, ... }:
{
	xdg.portal.extraPortals = [
		pkgs.xdg-desktop-portal-gtk
	];

	hm = {
		wayland.windowManager.hyprland = {
			settings = {
				windowrulev2 = [
					"float, class:(xdg-desktop-portal-gtk)"
					"center 1, class:(xdg-desktop-portal-gtk)"
					"size 1150 750, class:(xdg-desktop-portal-gtk)"
				];
			};
		};
	};
}


