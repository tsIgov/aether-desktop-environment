{ lib, config, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) ints str nullOr package;

	cfg = config.aether.theme.cursor;
in
{
	options.aether.theme.cursor = {
		name = mkOption { type = str; default = ""; };
		package =  mkOption { type = nullOr package; default = null; };
		size = mkOption { type = ints.positive; default = 22; };
	};

	config = {
		hm = {
			gtk.cursorTheme = {
				name = cfg.name;
				package = cfg.package;
				size = cfg.size;
			};

			home.sessionVariables = {
				HYPRCURSOR_THEME = cfg.name;
				HYPRCURSOR_SIZE = cfg.size ;
			};
		};
	};
}
