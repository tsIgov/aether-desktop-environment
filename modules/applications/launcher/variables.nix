{ pkgs, config, aether, ... }:
let
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	hm = {
		home.file.".config/rofi/variables.rasi".text = ''
* {
  text:           #${palette.text};
  subtext1:       #${palette.subtext1};
  subtext0:       #${palette.subtext0};
  overlay2:       #${palette.overlay2};
  overlay1:       #${palette.overlay1};
  overlay0:       #${palette.overlay0};
  surface2:       #${palette.surface2};
  surface1:       #${palette.surface1};
  surface0:       #${palette.surface0};
  base:           #${palette.base};
  mantle:         #${palette.mantle};
  crust:          #${palette.crust};

  primary: 		  #${palette.primary};
  secondary: 	  #${palette.secondary};
  tertiary:		  #${palette.tertiary};
  error: 		  #${palette.error};
}

configuration {
  font: "${config.aether.appearance.fonts.regular} 12";
}
		'';
	};
}
