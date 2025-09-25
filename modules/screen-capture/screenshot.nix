{ pkgs, config, aether, ... }:
let
	palette = aether.lib.appearance.getPalette { inherit config; };
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
			selectionBorderColor = "#${palette.primary}ff";
			overlayColor = "#${palette.overlay0}4c";
		};
		mode = "0555";
	};

	hm = {
		home.file = {
			".config/satty/config.toml".source = pkgs.replaceVars ./satty.toml {
				inherit outputDir;
				font = config.aether.appearance.fonts.mono;
				colors1 = palette.primary;
				colors2 = palette.secondary;
				colors3 = palette.tertiary;
				colors4 = palette.error;

				palette01 = palette.text;
				palette02 = palette.subtext1;
				palette03 = palette.subtext0;
				palette04 = palette.overlay2;
				palette05 = palette.overlay1;
				palette06 = palette.overlay0;
				palette07 = palette.surface2;
				palette08 = palette.surface1;
				palette09 = palette.surface0;
				palette10 = palette.base;
				palette11 = palette.mantle;
				palette12 = palette.crust;
				palette13 = palette.rosewater;
				palette14 = palette.flamingo;
				palette15 = palette.pink;
				palette16 = palette.red;
				palette17 = palette.maroon;
				palette18 = palette.peach;
				palette19 = palette.yellow;
				palette20 = palette.green;
				palette21 = palette.teal;
				palette22 = palette.sky;
				palette23 = palette.sapphire;
				palette24 = palette.blue;
				palette25 = palette.lavender;
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
