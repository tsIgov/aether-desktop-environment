{ lib, aetherLib, ... }:
{
	options.aether.appearance = with lib; with types; {
		flavor = mkOption { type = enum aetherLib.appearance.validFlavors; };
		accent = mkOption { type = enum aetherLib.appearance.validAccents; };
	};
}
