{ config }:
let
	flavorName = config.aether.appearance.colors.flavor;
  	accentName = config.aether.appearance.colors.accent;
	flavor = (import ./flavors.nix).${flavorName};
in
with flavor; {
	accent = flavor.${accentName};

	inherit rosewater flamingo pink mauve red maroon peach yellow
			green teal sky sapphire blue lavender
			text subtext1 subtext0 overlay2 overlay1 overlay0
			surface2 surface1 surface0
			base mantle crust;
}
