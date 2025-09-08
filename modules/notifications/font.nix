{ config, ... }:
{
	hm = {
		home.file.".config/swaync/font.css".text = ''
* {
  font-family: "${config.aether.appearance.fonts.regular}";
}
		'';
	};
}
