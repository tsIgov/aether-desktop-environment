{ lib }:
rec {
	flavors = import ./flavors.nix;
	getPalette = import ./getPalette.nix;
	validFlavors = import ./validFlavors.nix;
	validAccents = import ./validAccents.nix;
	getGtkColorDefinitions = import ./getGtkColorDefinitions.nix getPalette;
	hexToRgb = import ./hexToRgb.nix lib;
}
