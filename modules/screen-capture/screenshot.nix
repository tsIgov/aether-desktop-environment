{ pkgs, config, ... }:
let
	palette = config.aether.theme.color-scheme;
	outputDir = "${config.hm.home.homeDirectory}/Pictures/Screenshots";
in
{
	environment.systemPackages = with pkgs; [
		slurp
		grim
		satty
	];

	environment.etc."aether/screen-capture/scripts/screenshot.sh" = {
		source = pkgs.replaceVars ./scripts/screenshot.sh {
			inherit outputDir;
			bash = "${pkgs.bash}/bin/bash";
			hyprctl = "${pkgs.hyprland}/bin/hyprctl";
			jq = "${pkgs.jq}/bin/jq";
			satty = "${pkgs.satty}/bin/satty";
			slurp = "${pkgs.slurp}/bin/slurp";
			grim = "${pkgs.grim}/bin/grim";
			selectionBorderColor = "#${palette.primary}ff";
			overlayColor = "#${palette.overlay}4c";
		};
		mode = "0555";
	};

	hm = {
		home.file = {
			".config/satty/config.toml".source = pkgs.replaceVars ./satty.toml {
				inherit outputDir;
				font = config.aether.theme.fonts.mono;
				colors1 = palette.primary;
				colors2 = palette.secondary;
				colors3 = palette.warning;
				colors4 = palette.error;

				palette01 = palette.foreground0;
				palette02 = palette.foreground1;
				palette03 = palette.foreground2;
				palette04 = palette.overlay;
				palette07 = palette.surface2;
				palette08 = palette.surface1;
				palette09 = palette.surface0;
				palette10 = palette.background0;
				palette11 = palette.background1;
				palette12 = palette.background2;
				palette13 = palette.red;
				palette14 = palette.blue;
				palette15 = palette.green;
				palette16 = palette.cyan;
				palette17 = palette.yellow;
				palette18 = palette.magenta;
				palette19 = palette.orange;
				palette20 = palette.violet;
			};
		};

		wayland.windowManager.hyprland = {
			settings = {
				layerrule = [
					"noanim, selection"
				];
			};
			extraConfig = ''
				bind = , PRINT, exec, sh /etc/aether/screen-capture/scripts/screenshot.sh
			'';
		};

	};
}
