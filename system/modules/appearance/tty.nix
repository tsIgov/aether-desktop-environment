{ pkgs, config, ... }:
let 
	variant = config.aether.system.appearance.variant;
	colors = (import ./../../../utilities/colors.nix).${variant};
in
{
	console = {
		font = "ter-124b";
		packages = with pkgs; [
			terminus_font
		];
		colors = [
			colors.base colors.red colors.green colors.yellow colors.blue colors.pink colors.teal colors.subtext0
			colors.surface0 colors.red colors.green colors.yellow colors.blue colors.pink colors.teal colors.subtext1
		];
	};
}