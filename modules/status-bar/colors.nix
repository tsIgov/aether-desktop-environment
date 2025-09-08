{ pkgs, config, aether, ... }:
let
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	hm = {
		home.file.".config/waybar/colors.css".text = ''
@define-color base #${palette.base};
@define-color mantle #${palette.mantle};
@define-color crust #${palette.crust};

@define-color text #${palette.text};
@define-color subtext0 #${palette.subtext0};
@define-color subtext1 #${palette.subtext1};

@define-color surface0 #${palette.surface0};
@define-color surface1 #${palette.surface1};
@define-color surface2 #${palette.surface2};

@define-color overlay0 #${palette.overlay0};
@define-color overlay1 #${palette.overlay1};
@define-color overlay2 #${palette.overlay2};

@define-color primary #${palette.primary};
@define-color secondary #${palette.secondary};
@define-color tertiary #${palette.tertiary};
@define-color error #${palette.error};
		'';
	};
}
