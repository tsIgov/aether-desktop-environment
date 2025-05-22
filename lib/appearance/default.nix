{
	flavors = import ./flavors.nix;
	getPalette = import ./getPalette.nix;
	validFlavors = import ./validFlavors.nix;
	validAccents = import ./validAccents.nix;
	getTerminalAccentColor = import ./getTerminalAccentColor.nix;
}
