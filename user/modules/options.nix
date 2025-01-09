{ config, lib, ... }:
{
	options.user = with lib; with types; {
		appearance.fontSize = mkOption { type = int; default = 12; };
	};
}