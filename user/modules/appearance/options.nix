{ lib, aether, ... }:
{
	options.aether.appearance = with lib; with types; {
		flavor = mkOption { type = enum aether.lib.appearance.validFlavors; };
		accent = mkOption { type = enum aether.lib.appearance.validAccents; };
	};
}
