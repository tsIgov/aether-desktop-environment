{ lib, ... }:
{
	options.aether.defaultApps = with lib; with types; {
		terminal = mkOption { type = pathInStore; };
		fileManager = mkOption { type = pathInStore; };
	};
}
