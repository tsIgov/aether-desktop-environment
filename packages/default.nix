{ pkgs, aetherLib }:
rec {
	aether = pkgs.callPackage ./aether { };
	aether-install = pkgs.callPackage ./aether-install { };
	recolor = pkgs.callPackage ./recolor { inherit aetherLib; };
	icons = pkgs.callPackage ./icons { inherit aetherLib recolor; };
	wallpapers = pkgs.callPackage ./wallpapers { inherit aetherLib; };
}
