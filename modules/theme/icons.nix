{ config, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str nullOr package;

	cfg = config.aether.theme.icons;
in
{

	options.aether.theme = {
		icons = {
			name = mkOption { type = str; default = ""; };
			package =  mkOption { type = nullOr package; default = null; };
		};
	};

	config = {
		hm = {
			gtk.iconTheme = {
				name = cfg.name;
				package = cfg.package;
			};
		};
	};
}
