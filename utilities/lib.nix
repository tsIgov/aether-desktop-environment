{ lib }:
let
	importNixpkgs = nixpkgs: import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
	getNixFilesRecursively = path: builtins.filter (n: lib.strings.hasSuffix ".nix" (builtins.toString n)) (lib.filesystem.listFilesRecursive path);

	createRecursiveModuleWithExtraArgs = path: extraArgs:
		args: 
		let
			newArgs = args // extraArgs;
			modules = getNixFilesRecursively path;
		in
		{ 
			imports = (builtins.map (file: import file newArgs) modules); 
		};

	res = {
		inherit 
			importNixpkgs 
			getNixFilesRecursively 
			createRecursiveModuleWithExtraArgs;
	};
in
	res