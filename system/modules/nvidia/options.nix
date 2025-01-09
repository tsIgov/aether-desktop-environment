{ lib, ... }:
{
	options.aether.system = with lib; with types; {
		nvidia = mkOption { type = enum [ "disabled" "offload" null]; default = null; };
	};
}