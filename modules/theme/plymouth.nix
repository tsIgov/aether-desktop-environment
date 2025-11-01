{ config, pkgs, lib, ... }:
let
	inherit (lib) mkOption mkIf;
	inherit (lib.types) str nullOr package path bool;

	cfg = config.aether.theme.plymouth;
in
{
	options = {
		aether.theme.plymouth = {
			font = mkOption { type = nullOr path; default = "The absolute path to a font for displaying text."; };
			package =  mkOption { type = nullOr package; default = null; description = "The package of the theme to use."; };
			name = mkOption { type = str; default = "bgrt"; description = "The name of the theme to use."; };
		};
	};

	config = {
		boot.plymouth = {
			enable = true;
			themePackages = [ cfg.package ];
			theme = cfg.name;
			logo = ../../logos/logo-64x64.png;
			font = cfg.font;
		};
	};
}
