{ config, lib, ... }:
{
	options.system = with lib; with types; {
		appearance.colorVariant = mkOption { type = enum [ "latte" "frappe" "macchiato" "mocha" ]; };
	};
}
