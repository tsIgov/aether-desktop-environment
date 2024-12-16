{
  description = "Aether desktop environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, hyprland, ... }: 
  let
    lib = import ./utilities/lib.nix { lib = nixpkgs.lib; };
    pkgs = lib.importNixpkgs nixpkgs;

    args = {
      inherit pkgs;
      custom-pkgs = import ./custom-packages/default.nix { inherit pkgs; };
      hyprland-pkgs = lib.importNixpkgs hyprland;
    };

  in {
    inherit lib;

    nixosModules = { 
      system =  lib.createRecursiveModuleWithExtraArgs ./modules/system args; 
      user =  lib.createRecursiveModuleWithExtraArgs ./modules/user args; 
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
