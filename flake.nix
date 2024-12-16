{
  description = "Aether desktop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    lib = import ./utilities/lib.nix { lib = nixpkgs.lib; };
    pkgs = lib.importNixpkgs nixpkgs;

    attr = {
      inherit pkgs; 
      custom-pkgs = import ./custom-packages/default.nix { inherit pkgs; };
    };

  in {
    inherit lib;

    nixosModules = { 
      system =  lib.importModulesRecursivelyWithOverridenPkgs ./modules/system attr; 
      user =  lib.importModulesRecursivelyWithOverridenPkgs ./modules/user attr; 
    };

    templates = {
      system = {
        path = ./templates/system;
        description = "";
        # welcomeText = "
        #   # Getting Started
        #   - markdown list item
        # ";
      };
    };
  };
}
