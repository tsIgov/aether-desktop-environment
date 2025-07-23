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

	home = { pkgs, ... }:
	{
		wayland.windowManager.hyprland = {
			enable = true;

			settings = {
				ecosystem = {
					no_update_news = true;
					no_donation_nag = true;
				};
			};
		};

		home.file.".config/hypr/scripts".source = ./scripts;
	};
}
