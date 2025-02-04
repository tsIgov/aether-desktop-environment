{
	system = { pkgs, config, aether, ... }:
	let 
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		environment.systemPackages = with pkgs; [
			(where-is-my-sddm-theme.override {
				themeConfig.General = {
					backgroundFill = "#${palette.base}";
					basicTextColor = "#${palette.subtext0}";
					passwordCursorColor = "#${palette.accent}";
					passwordInputBackground = "#${palette.base}";
					passwordTextColor = "#${palette.accent}";
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
	};
}
