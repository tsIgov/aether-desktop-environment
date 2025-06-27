{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			rofi-power-menu
			rofi-screenshot
			rofi-bluetooth
		];
	};

	home = { pkgs, ... }:
	{
		programs.rofi = {
			enable = true;
			package = pkgs.rofi-wayland;
			plugins = with pkgs; [
				rofi-calc
				rofi-top
			];
			theme = ".config/rofi/theme.rasi";
		};

		home.file.".config/rofi/theme.rasi".source = ./theme.rasi;
		home.file.".config/rofi/colors.rasi".source = ./colors.rasi;
		home.file.".config/rofi/scripts".source = ./scripts;
	};
}
