{ config, lib, ... }:
let
	inherit (lib) mkOption mkIf;
	inherit (lib.types) nullOr str;

	cfg = config.aether.localization;
in
{
	options.aether.localization = {
		timezone = mkOption { type = str; default = "auto"; };
	};

	config = {
		time.timeZone = mkIf (cfg.timezone != "auto") cfg.timezone;
		services.tzupdate.enable = mkIf (cfg.timezone == "auto") true;
	};
}
