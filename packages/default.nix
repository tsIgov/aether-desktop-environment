{ pkgs, aetherLib }:
rec {
	recolor = pkgs.callPackage ./recolor { inherit aetherLib; };
	icons = pkgs.callPackage ./icons { inherit aetherLib recolor; };
}