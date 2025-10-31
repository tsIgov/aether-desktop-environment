{ pkgs, config, ... }:
let
	palette = config.aether.theme.color-scheme;
in
{
	environment.systemPackages = with pkgs; [
		(where-is-my-sddm-theme.override {
			themeConfig.General = {
				backgroundFill = "#${palette.background0}";
				basicTextColor = "#${palette.foreground1}";
				passwordCursorColor = "#${palette.primary}";
				passwordInputBackground = "#${palette.background0}";
				passwordTextColor = "#${palette.primary}";
				cursorBlinkAnimation = true;
				hideCursor = true;
			};
		})
	];

	services.displayManager.sddm = {
		enable = true;
		package = pkgs.kdePackages.sddm;
		theme = "where_is_my_sddm_theme";
		extraPackages = [
			pkgs.kdePackages.qt5compat
		];
		wayland = {
			enable = true;
			compositor = "kwin";
		};
		autoNumlock = true;
	};
}
