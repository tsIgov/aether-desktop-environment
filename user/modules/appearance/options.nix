{ config, lib, aetherLib, ... }:
{
	options.aether.appearance = with lib; with types; {
		variant = mkOption { type = enum aetherLib.flavors; };
		accent = mkOption { type = enum [ 
			"rosewater" 
			"flamingo" 
			"pink" 
			"mauve" 
			"red" 
			"maroon" 
			"peach" 
			"yellow" 
			"green" 
			"teal" 
			"sky" 
			"sapphire" 
			"blue" 
			"lavender" 
		];};
	};
}
