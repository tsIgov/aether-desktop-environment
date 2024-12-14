{ lib }:
let
	importModules = path: lib.filter (n: lib.strings.hasSuffix ".nix" (builtins.toString n)) (lib.filesystem.listFilesRecursive path);

	res = {
		inherit importModules;
	};
in
	res