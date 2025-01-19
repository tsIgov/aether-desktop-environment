{ pkgs, aetherLib }:
rec {
	recolor = pkgs.callPackage ./recolor { inherit aetherLib; };
}