{
  description = "Aether desktop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    lib = nixpkgs.lib;

    createRecursiveModule = path:	args: 
		let
			newArgs = args // { inherit pkgs; };
			modules = builtins.filter (n: lib.strings.hasSuffix ".nix" (toString n)) (lib.filesystem.listFilesRecursive path);
		in
		{ 
			imports = (builtins.map (file: import file newArgs) modules); 
		};

  in {
    nixosModule = createRecursiveModule ./modules/system;  
    homeManagerModule = createRecursiveModule ./modules/home;  
  };
}
