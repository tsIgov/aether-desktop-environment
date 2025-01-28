{ pkgs, config, aether, ... }:
let 
	flavorName = config.aether.appearance.flavor;
	flavor = aether.lib.appearance.flavors.${flavorName};
in
{
	console = {
		font = "ter-124b";
		packages = with pkgs; [
			terminus_font
		];
		colors = with flavor; [
			base red green yellow blue pink teal subtext0
			surface0 red green yellow blue pink teal subtext1
		];
	};
}