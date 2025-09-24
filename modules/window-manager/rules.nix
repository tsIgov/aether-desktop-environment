{ ... }:
{
	hm = {

		wayland.windowManager.hyprland = {
			settings = {

				windowrulev2 = [
					"float, class:(xdg-desktop-portal-gtk)"
					"center 1, class:(xdg-desktop-portal-gtk)"
					"size 1150 750, class:(xdg-desktop-portal-gtk)"
				];

				workspace = [
					"special:quick-1, gapsout:100"
					"special:quick-2, gapsout:100"
					"special:quick-3, gapsout:100"
					"special:quick-4, gapsout:100"
					"special:quick-5, gapsout:100"
				];
			};

		};
	};
}
