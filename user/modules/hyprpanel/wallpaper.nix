{ pkgs, ... }:
{
	programs.hyprpanel = {
		settings = {
			wallpaper = {
				enable = false;
				image = "/home/igov/recolor/test/graphics/wallpapers/lake_cabin.png";
				pywal = false;
			};

			theme.matugen = false;
		};
	};
}