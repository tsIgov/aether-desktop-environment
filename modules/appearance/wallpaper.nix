{ config, aether, pkgs, ... }:
let
	wallpapersPkg = (aether.pkgs.wallpapers.override {
			flavor = config.aether.appearance.colors.flavor;
			accent = config.aether.appearance.colors.primary;
	});
	wallpaper = "${wallpapersPkg}/${config.aether.appearance.wallpaper}.png";

in
{
	hm = {
		home.packages = [
			wallpapersPkg
			pkgs.hyprpaper
		];

		services.hyprpaper = {
			enable = true;
			settings = {
				ipc = "off";
				splash = false;

				preload = [ "${wallpaper}" ];

				wallpaper = [
					",${wallpaper}"
				];
			};
		};
	};
}
