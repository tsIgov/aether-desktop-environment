{ lib, aether, ... }:
{
	options.aether.storage = with lib; with types; {
		garbage-collection = {
			enable = mkOption { type = bool; default = true; description = "Automatically run the garbage collector."; };
			schedule = mkOption { type = singleLineStr; default = "Mon 06:00"; description = "How often or when garbage collection is performed. This value must be a calendar event in the format specified by {manpage}`systemd.time(7)`."; };
			daysOld = mkOption { type = ints.positive; default = 7; description = "Delete all inactive generations older than the specified amount of days."; };
		};
	};
}
