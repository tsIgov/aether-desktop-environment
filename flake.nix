{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
	let
		overlays = [
			(final: prev: {
				rofi-calc = prev.rofi-calc.overrideAttrs (old: {
					version = "2.4.0";
					src = prev.fetchFromGitHub {
						owner = "svenstaro";
						repo = "rofi-calc";
						rev = "v2.4.0";
						sha256 = "sha256:iTLi76GinRASawPSWAqmxSwLZPGvHesarHNoqO4m4dM=";
					};
				});
			})
		];

		pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; inherit overlays; };
		aetherLib = import ./lib inputs.nixpkgs.lib;
		internal = import ./internal aetherLib;

		aether = {
			lib = aetherLib;
			pkgs = import ./packages { inherit pkgs aetherLib; };
			inputs = inputs;
		};
	in
	{
		lib = aetherLib;
		systemConfig = import ./system.nix { inherit aether pkgs internal; };
		userConfig = import ./home.nix { inherit aether pkgs internal; };
	};
}
