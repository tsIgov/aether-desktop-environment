{ config }:
let
	map = {
		rosewater = "red";
		flamingo = "red";
		pink = "magenta";
		mauve = "magenta";
		red = "red";
		maroon = "red";
		peach = "yellow";
		yellow = "yellow";
		green = "green";
		teal = "cyan";
		sky = "cyan";
		sapphire = "cyan";
		blue = "blue";
		lavender = "blue";
	};

  	accentName = config.aether.appearance.colors.accent;
in
map.${accentName}
