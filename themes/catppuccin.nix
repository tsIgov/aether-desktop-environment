{ pkgs, lib, aetherPkgs, aetherLib }:
{ flavor ? "mocha" }:
let
	accent = "mauve";

	color-schemes = {
		mocha = rec {
			background0 = "1e1e2e";
			background1 = "181825";
			background2 = "11111b";

			surface0 = "313244";
			surface1 = "45475a";
			surface2 = "585b70";

			overlay = "6c7086";

			foreground0 = "cdd6f4";
			foreground1 = "bac2de";
			foreground2 = "a6adc8";

			red = "f38ba8";
			blue = "89b4fa";
			green = "a6e3a1";
			cyan = "89dceb";
			yellow = "f9e2af";
			magenta = "f5c2e7";
			orange = "fab387";
			violet = "cba6f7";

			primary = violet;
			secondary = green;
			warning = orange;
			error = red;
		};
	};
in
{
	color-scheme = color-schemes.${flavor};

	fonts = {
		size = 11;
		regular = "Inter";
		mono = "Hack Nerd Font Mono";
		emoji = "Noto Emoji";
		icons = "Hack Nerd Font Propo";
		packages = with pkgs; [
			inter
			nerd-fonts.hack
			noto-fonts-monochrome-emoji
		];
	};

	cursor =
	let
		packageOutput = flavor + (lib.toUpper (lib.substring 0 1 accent)) + (lib.substring 1 (builtins.stringLength accent - 1) accent);
	in
	{
		name = "catppuccin-${flavor}-${accent}-cursors";
		package = pkgs.catppuccin-cursors.${packageOutput};
	};

	gtk = {
		dark = true;
		theme-name = "catppuccin-${flavor}-${accent}-standard+normal";
		theme-package = pkgs.catppuccin-gtk.override {
			accents = [ accent ];
			size = "standard";
			tweaks = [ "normal" ];
			variant = flavor;
		};
	};

	qt = {
		theme-name = "catppuccin-${flavor}-${accent}";
		theme-package = pkgs.catppuccin-kvantum.override {
			variant = flavor;
			accent =  accent;
		};
	};

	wallpaper = rec	{
		package = aetherPkgs.wallpapers.override {
			background-color = color-schemes.${flavor}.background0;
			foreground-color = color-schemes.${flavor}.primary;
		};
		path = "${package}/deer.png";
	};

	icons = {
		name = "aether-icons";
		package = aetherPkgs.icons.override {
			color-scheme = color-schemes.${flavor};
		};
	};
}
