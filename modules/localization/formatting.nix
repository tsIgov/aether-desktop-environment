{ config, lib, ... }:
let
	inherit (lib) mkOption mkIf;
	inherit (lib.types) nullOr str;

	cfg = config.aether.localization;
in
{
	options.aether.localization = {
		default = mkOption { type = str; default = "en_DK.UTF-8"; };
		address = mkOption { type = nullOr str; default = null; };
		measurements = mkOption { type = nullOr str; default = null; };
		money = mkOption { type = nullOr str; default = "en_IE.UTF-8"; };
		names = mkOption { type = nullOr str; default = null; };
		numeric = mkOption { type = nullOr str; default = null; };
		paper = mkOption { type = nullOr str; default = null; };
		telephone = mkOption { type = nullOr str; default = null; };
		time = mkOption { type = nullOr str; default = null; };
	};

	config = {
		i18n = {
			extraLocales =  "all";
			defaultLocale = cfg.default;
			extraLocaleSettings = {
				LC_NUMERIC = mkIf (cfg.numeric != null) cfg.numeric;
				LC_TIME = mkIf (cfg.time != null) cfg.time;
				LC_MONETARY = mkIf (cfg.money != null) cfg.money;
				LC_PAPER = mkIf (cfg.paper != null) cfg.paper;
				LC_NAME = mkIf (cfg.names != null) cfg.names;
				LC_ADDRESS = mkIf (cfg.address != null) cfg.address;
				LC_TELEPHONE = mkIf (cfg.telephone != null) cfg.telephone;
				LC_MEASUREMENT = mkIf (cfg.measurements != null) cfg.measurements;
			};
		};

		hm = {
			home.language = {
				base = cfg.default;
				address = cfg.address;
				measurement = cfg.measurements;
				monetary = cfg.money;
				name = cfg.names;
				numeric = cfg.numeric;
				paper = cfg.paper;
				telephone = cfg.telephone;
				time = cfg.time;
			};
		};
	};
}
