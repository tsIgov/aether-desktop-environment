{ lib, aether, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) enum;
	inherit (aether.lib.appearance) validAccents validFlavors;
in
{
	options.aether.appearance.colors = {
		flavor = mkOption { type = enum validFlavors; default = "mocha"; };
		primary = mkOption { type = enum validAccents; default = "mauve"; };
		secondary = mkOption { type = enum validAccents; default = "green"; };
		tertiary = mkOption { type = enum validAccents; default = "peach"; };
		error = mkOption { type = enum validAccents; default = "red"; };
	};
}
