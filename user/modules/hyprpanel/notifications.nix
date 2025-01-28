{ pkgs, ... }:
{
	programs.hyprpanel = {
		settings = {
			bar.notifications = {
				hideCountWhenZero = true;
				show_total = true;
			};

			notifications = {
				active_monitor = true;
				cache_actions = true;
				clearDelay = 100;
				displayedTotal = 10;
				position = "top";
				showActionsOnHover = false;
				timeout = 5000;
			};

			theme = {
				notification = {
					border_radius = "1rem";
					opacity = 100;
					scaling = 100;
				};

				bar = {
					buttons.clock.spacing = "0";
					menus.menu.notifications = {
						height = "50em";
						pager.show = true;
						scaling = 100;
						scrollbar = {
							radius = "1rem";
							width = "0.35em";
						};
					};
				};
			};
		};

   		override.notifications.autoDismiss = true;

	};
}