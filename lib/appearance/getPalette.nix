{ config }:
let 
	flavors = import ./flavors.nix;

	complimentary = {
		rosewater = "flamingo";
		flamingo = "rosewater";
		pink = "mauve";
		mauve = "pink";
		red = "maroon";
		maroon = "red";
		peach = "yellow";
		yellow = "peach";
		green = "teal";
		teal = "green";
		sky = "sapphire";
		sapphire = "sky";
		blue = "lavender";
		lavender = "blue";
	};

	flavorName = config.aether.appearance.flavor;
	flavor = flavors.${flavorName};
  	accentName = config.aether.appearance.accent;
	complimentaryName = complimentary.${accentName};
in
{
	accent = flavor.${accentName};
	complimentary = flavor.${complimentaryName};

	rosewater = flavor.rosewater;
	flamingo = flavor.flamingo;
	pink = flavor.pink;
	mauve = flavor.mauve;
	red = flavor.red;
	maroon = flavor.maroon;
	peach = flavor.peach;
	yellow = flavor.yellow;
	green = flavor.green;
	teal = flavor.teal;
	sky = flavor.sky;
	sapphire = flavor.sapphire;
	blue = flavor.blue;
	lavender = flavor.lavender;

	text = flavor.text;
	subtext1 = flavor.subtext1;
	subtext0 = flavor.subtext0;
	overlay2 = flavor.overlay2;
	overlay1 = flavor.overlay1;
	overlay0 = flavor.overlay0;
	surface2 = flavor.surface2;
	surface1 = flavor.surface1;
	surface0 = flavor.surface0;
	base = flavor.base;
	mantle = flavor.mantle;
	crust = flavor.crust;
}