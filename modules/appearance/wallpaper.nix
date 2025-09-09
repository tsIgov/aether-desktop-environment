{ config, aether, pkgs, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types)ints enum;

	wallpapersPkg = (aether.pkgs.wallpapers.override {
			flavor = config.aether.appearance.colors.flavor;
			accent = config.aether.appearance.colors.primary;
	});
	wallpaper = "${wallpapersPkg}/${config.aether.appearance.wallpaper}.png";
in
{
	options.aether.appearance.wallpaper = mkOption { type = enum [ "deer" ]; default = "deer"; };

	config = {
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
	};
}
