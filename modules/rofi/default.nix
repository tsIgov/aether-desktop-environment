{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			rofi-power-menu
			rofi-screenshot
			rofi-bluetooth
		];
	};

	home = { pkgs, config, ... }:
	{
		programs.rofi = {
			enable = true;
			package = pkgs.rofi-wayland;
			plugins = with pkgs; [
				rofi-calc
				rofi-top
			];
			extraConfig = {
				"// calc" = config.lib.formats.rasi.mkLiteral ''

				calc {
					no-bold: false;
					terse: true;
					no-history: true;
					no-persist-history: true;
					automatic-save-to-history: true;
					calc-command-history: true;
					calc-error-color: "@red";
					calc-command: "echo -n '{result}' | wl-copy";
					hint-result: "";
					hint-welcome: "";
				}
				// '';
			};
			theme = ".config/rofi/theme.rasi";
		};

		home.file.".config/rofi/theme.rasi".source = ./theme.rasi;
		home.file.".config/rofi/colors.rasi".source = ./colors.rasi;
		home.file.".config/rofi/scripts".source = ./scripts;
	};
}
