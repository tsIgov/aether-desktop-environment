{ pkgs, config, aether, ... }:
{
	hm = {
		home.file.".config/waybar/fonts.css".text = ''
* {
	font-family: ${config.aether.appearance.fonts.icons};
}

#clock.time,
#clock.cal,
#language,
tooltip {
	font-family: ${config.aether.appearance.fonts.mono};
}
		'';
	};
}
