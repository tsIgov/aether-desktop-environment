{ lib }:
let
	importNixpkgs = nixpkgs: import nixpkgs { system = builtins.currentSystem; config.allowUnfree = true; };
	getModulesRecursively = path: builtins.filter (n: lib.strings.hasSuffix ".nix" (builtins.toString n)) (lib.filesystem.listFilesRecursive path);

	importModulesRecursivelyWithOverridenPkgs = path: pkgs: 
		args: 
		let
			newArgs = args // { inherit pkgs; };
			modules = getModulesRecursively path;
		in
		{ 
			imports = (builtins.map (file: import file newArgs) modules); 
		};

	res = {
		inherit 
			importNixpkgs 
			getModulesRecursively 
			importModulesRecursivelyWithOverridenPkgs;
	};
in
	res