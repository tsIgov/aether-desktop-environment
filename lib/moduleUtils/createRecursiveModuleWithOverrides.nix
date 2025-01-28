listModulesRecursively:
path: overrides: 
args: 
let
	newArgs = args // overrides;
	modules = listModulesRecursively path;
in
{ 
	imports = builtins.map (file: import file newArgs) modules; 
}