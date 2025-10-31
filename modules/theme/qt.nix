{ config, lib, pkgs, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str nullOr package;

	cfg = config.aether.theme.qt;
in
{
	options = {
		aether.theme.qt = {
			theme-name = mkOption { type = str; default = ""; };
			theme-package =  mkOption { type = nullOr package; default = null; };
		};
	};

	config = {
		hm = {
			home.packages = with pkgs; [
				qt5.qtwayland
				qt6.qtwayland
				kdePackages.qtstyleplugin-kvantum
			];

			qt = {
				enable = true;
				platformTheme.name = "kvantum";
				style = {
					name = "kvantum";
					package = cfg.theme-package;
				};
			};

			xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
				General.theme = cfg.theme-name;
			};
		};
	};
}
