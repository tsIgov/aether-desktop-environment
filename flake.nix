{
  description = "Aether desktop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    lib = import ./utilities/lib.nix { lib = nixpkgs.lib; };
    pkgs = lib.importNixpkgs nixpkgs;

  in {
    inherit lib;

    nixosModules = { 
      system =  lib.importModulesRecursivelyWithOverridenPkgs ./modules/system pkgs; 
      user =  lib.importModulesRecursivelyWithOverridenPkgs ./modules/user pkgs; 
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
