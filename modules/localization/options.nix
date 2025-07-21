{

	system = { lib, aether, ... }:
	{
		options.aether = with lib; with types; {
			localization = {
				timezone = mkOption { type = str; default = "auto"; };
			};
		};
	};

	home = { lib, aether, pkgs, ... }:
	{
		options.aether = with lib; with types; {
			localization = {
				default = mkOption { type = str; default = "en_US.UTF-8"; };
				addressFormat = mkOption { type = nullOr str; default = null; };
				measurementsFormat = mkOption { type = nullOr str; default = null; };
				moneyFormat = mkOption { type = nullOr str; default = null; };
				namesFormat = mkOption { type = nullOr str; default = null; };
				numericFormat = mkOption { type = nullOr str; default = null; };
				paperFormat = mkOption { type = nullOr str; default = null; };
				telephoneFormat = mkOption { type = nullOr str; default = null; };
				timeFormat = mkOption { type = nullOr str; default = null; };
			};
		};
	};

}
