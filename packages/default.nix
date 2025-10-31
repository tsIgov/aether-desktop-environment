{ pkgs, lib, aetherLib }:
rec {
	aether = pkgs.callPackage ./aether { };
	aether-install = pkgs.callPackage ./aether-install { };
	recolor = pkgs.callPackage ./recolor { };
	icons = pkgs.callPackage ./icons { inherit recolor; };
	wallpapers = pkgs.callPackage ./wallpapers { };
}
