{ config, pkgs, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str nullOr package;

	cfg = config.aether.theme.wallpaper;
in
{
	options = {
		aether.theme.wallpaper = {
			path = mkOption { type = str; default = ""; };
			package =  mkOption { type = nullOr package; default = null; };
		};
	};

	config = {
		environment.systemPackages = [
			pkgs.hyprpaper
			cfg.package
		];

		hm = {
			services.hyprpaper = {
				enable = true;
				settings = {
					ipc = "off";
					splash = false;
					preload = [ cfg.path ];
					wallpaper = [
						",${cfg.path}"
					];
				};
			};
		};
	};
}
