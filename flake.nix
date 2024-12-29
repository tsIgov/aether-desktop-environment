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
      scripts =  lib.createRecursiveModuleWithExtraArgs ./modules/scripts args; 
      aether =  lib.createRecursiveModuleWithExtraArgs ./modules/system args; 
    };

    homeManagerModules = {
      aether = lib.createRecursiveModuleWithExtraArgs ./modules/home args; 
    };

  };
}
