{ lib, ... }:
{
	options.aether = with lib; with types; {
		localization = {
			timezone = mkOption { type = str; default = "auto"; };

			default = mkOption { type = str; default = "en_DK.UTF-8"; };
			addressFormat = mkOption { type = nullOr str; default = null; };
			measurementsFormat = mkOption { type = nullOr str; default = null; };
			moneyFormat = mkOption { type = nullOr str; default = "en_IE.UTF-8"; };
			namesFormat = mkOption { type = nullOr str; default = null; };
			numericFormat = mkOption { type = nullOr str; default = null; };
			paperFormat = mkOption { type = nullOr str; default = null; };
			telephoneFormat = mkOption { type = nullOr str; default = null; };
			timeFormat = mkOption { type = nullOr str; default = null; };
		};
	};
}
