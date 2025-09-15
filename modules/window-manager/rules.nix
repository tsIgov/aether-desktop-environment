{ ... }:
{
	hm = {

		wayland.windowManager.hyprland = {
			settings = {

				windowrulev2 = [
					"float, class:(xdg-desktop-portal-gtk), title:^(.*Open.*)$"
					"center 1, class:(xdg-desktop-portal-gtk), title:^(.*Open.*)$"
					"size 1150 750, class:(xdg-desktop-portal-gtk), title:^(.*Open.*)$"

					"float, class:(xdg-desktop-portal-gtk), title:^(.*Save.*)$"
					"center 1, class:(xdg-desktop-portal-gtk), title:^(.*Save.*)$"
					"size 1150 750, class:(xdg-desktop-portal-gtk), title:^(.*Save.*)$"
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
