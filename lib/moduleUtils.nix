lib:
rec {
	listModulesRecursively = path: 
		builtins.filter (n: lib.strings.hasSuffix ".nix" (toString n)) (lib.filesystem.listFilesRecursive path);


	createRecursiveModuleWithOverrides =  path: overrides: 
		{lib, ...}@args: 
		let
			newArgs = args // overrides;
			modules = listModulesRecursively path;
		in
		{ 
			imports = builtins.map (file: import file newArgs) modules; 
		};
}