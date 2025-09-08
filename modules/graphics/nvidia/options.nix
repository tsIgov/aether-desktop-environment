{ lib, aether, ... }:
{
	options.aether.graphics = with lib; with types; {
		nvidia = with lib; with types; {
			enable = mkOption { type = bool; default = false; };
			drivers = mkOption { type = enum [ "nvidia" "nvidia-proprietary" "nouveau" "disabled" ]; default = "nvidia"; };
			prime = {
				enable = mkOption { type = bool; default = false; };
				type = mkOption { type = enum [ "offload" "sync" "reverseSync" ]; default = "offload"; };
			};
		};
	};
}
