{
  description = "Aether desktop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    lib = nixpkgs.lib;
    args = {
      packages = import nixpkgs { system = builtins.currentSystem; config.allowUnfree = true; };
    };

    importModules = path: lib.map (x: import x args) (lib.filter (n: lib.strings.hasSuffix ".nix" (builtins.toString n)) (lib.filesystem.listFilesRecursive path));
  in {
    lib = import ./utilities/lib.nix { lib = nixpkgs.lib; };

    nixosModules = { 
      system = {...}:{ imports = importModules ./modules/system; }; 
    };
  };
}
