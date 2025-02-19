{
	system = { config, lib, ... }:
	let
		cfg = config.aether.localization;
	in
	{
		time.timeZone = lib.mkIf (cfg.timezone != "auto") cfg.timezone;
		services.tzupdate.enable = lib.mkIf (cfg.timezone == "auto") true;
	};

	home = { config, lib, ... }:
	let
		cfg = config.aether.localization;
	in
	{
		home.language = {
			base = cfg.default;
			address = cfg.addressFormat;
			measurement = cfg.measurementsFormat;
			monetary = cfg.moneyFormat;
			name = cfg.namesFormat;
			numeric = cfg.numericFormat;
			paper = cfg.paperFormat;
			telephone = cfg.telephoneFormat;
			time = cfg.timeFormat;
		};
	};
}
