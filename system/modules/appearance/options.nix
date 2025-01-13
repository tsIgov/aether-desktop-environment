{ config, lib, ... }:
{
	options.aether.appearance = with lib; with types; {
		variant = mkOption { type = enum [ "latte" "frappe" "macchiato" "mocha" ]; };
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
