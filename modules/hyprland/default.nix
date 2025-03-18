{
	system = { pkgs, ... }:
	{
		programs.hyprland = {
			enable = true;
			xwayland.enable = true;
			withUWSM = true;
		};

		xdg.portal.extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];

		environment.sessionVariables = {
			"NIXOS_OZONE_WL" = "1";
			"ELECTRON_OZONE_PLATFORM_HINT" = "wayland";
		};
	};

	home = { ... }:
	{
		wayland.windowManager.hyprland = {
			enable = true;

			settings = {

				general = {
					no_focus_fallback = true;
					resize_on_border = true;
				};

				misc = {
					disable_autoreload = false;

					focus_on_activate = true;
					mouse_move_focuses_monitor = false;

					close_special_on_empty = true;
					new_window_takes_over_fullscreen = 2;

					initial_workspace_tracking = 1;
					middle_click_paste = false;
				};

				binds = {
					focus_preferred_method = 1;
					movefocus_cycles_fullscreen = true;
					window_direction_monitor_fallback = true;
				};
			};
		};
	};
}
