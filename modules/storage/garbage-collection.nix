{ lib, config, pkgs, ... }:
let
	inherit (lib) mkOption mkIf;
	inherit (lib.types) bool singleLineStr ints;

	cfg = config.aether.storage.garbage-collection;
in
{
	options.aether.storage.garbage-collection = {
		enable = mkOption { type = bool; default = true; description = "Automatically run the garbage collector."; };
		schedule = mkOption { type = singleLineStr; default = "Mon 06:00"; description = "How often or when garbage collection is performed. This value must be a calendar event in the format specified by {manpage}`systemd.time(7)`."; };
		daysOld = mkOption { type = ints.positive; default = 7; description = "Delete all inactive generations older than the specified amount of days."; };
	};

	config = {
		nix = {
			gc = {
				automatic = cfg.enable;
				persistent = true;
				dates = cfg.schedule;
				options = "--delete-older-than ${toString cfg.daysOld}d";
			};

			optimise = {
				automatic = cfg.enable;
				persistent = true;
				dates = cfg.schedule;
			};
		};

		environment.etc = {
			"aether/storage/scripts/garbage-collect.sh" = {
				source = pkgs.replaceVars ./scripts/garbage-collect.sh {
					bash = "${pkgs.bash}/bin/bash";
				};
				mode = "0555";
			};
		};
	};
}
