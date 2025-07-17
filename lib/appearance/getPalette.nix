{ config }:
let
	flavorName = config.aether.appearance.colors.flavor;
  	primaryName = config.aether.appearance.colors.primary;
  	secondaryName = config.aether.appearance.colors.secondary;
  	tertiaryName = config.aether.appearance.colors.tertiary;
  	errorName = config.aether.appearance.colors.error;

	flavor = (import ./flavors.nix).${flavorName};
in
with flavor; {
	primary = flavor.${primaryName};
	secondary = flavor.${secondaryName};
	tertiary = flavor.${tertiaryName};
	error = flavor.${errorName};

	inherit rosewater flamingo pink mauve red maroon peach yellow
			green teal sky sapphire blue lavender
			text subtext1 subtext0 overlay2 overlay1 overlay0
			surface2 surface1 surface0
			base mantle crust;
}
