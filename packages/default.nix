{ pkgs, aetherLib }:
rec {
	aether = pkgs.callPackage ./aether { };
	recolor = pkgs.callPackage ./recolor { inherit aetherLib; };
	icons = pkgs.callPackage ./icons { inherit aetherLib recolor; };
	wallpapers = pkgs.callPackage ./wallpapers { inherit aetherLib; };
}
