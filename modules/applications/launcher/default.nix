{
	home = { pkgs, config, ... }:
	{
		programs.rofi = {
			enable = true;
			package = pkgs.rofi-wayland;
			plugins = with pkgs; [
				rofi-calc
			];
			theme = ".config/rofi/configuration.rasi";
		};

		home.file.".config/rofi/configuration.rasi".source = ./configuration.rasi;
		home.file.".config/rofi/theme.rasi".source = ./theme.rasi;
		home.file.".config/rofi/colors.rasi".source = ./colors.rasi;
	};
}
