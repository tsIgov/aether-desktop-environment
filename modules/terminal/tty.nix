{ pkgs, config, aether, ... }:
let
	palette = aether.lib.appearance.getPalette { inherit config; };
	hexToRgb = aether.lib.appearance.hexToRgb;
	colors = {
		background = hexToRgb { hex = palette.base; };
		foreground = hexToRgb { hex = palette.text; };

		black = hexToRgb { hex = palette.surface1; };
		light-black = hexToRgb { hex = palette.surface2; };

		white = hexToRgb { hex = palette.text; };
		light-white = hexToRgb { hex = palette.subtext0; };

		red = hexToRgb { hex = palette.red; };
		green = hexToRgb { hex = palette.green; };
		yellow = hexToRgb { hex = palette.yellow; };
		blue = hexToRgb { hex = palette.blue; };
		magenta = hexToRgb { hex = palette.mauve; };
		cyan = hexToRgb { hex = palette.sky; };

		light-red = hexToRgb { hex = palette.maroon; };
		light-green = hexToRgb { hex = palette.teal; };
		light-yellow = hexToRgb { hex = palette.peach; };
		light-blue = hexToRgb { hex = palette.lavender; };
		light-magenta = hexToRgb { hex = palette.pink; };
		light-cyan = hexToRgb { hex = palette.sapphire; };
	};
in
{
	console.enable = false;

	services.kmscon = {
		enable = true;
		fonts = [ { name = config.aether.appearance.fonts.mono; package = pkgs.nerd-fonts.hack; } ];
		hwRender = true;
		autologinUser = config.aether.user.username;
		extraOptions = "--term xterm-256color";
		extraConfig = ''
			xkb-layout=us
			xkb-variant={xkb default}
			xkb-options={xkb default}

			palette=custom
			palette-black=${colors.black}
			palette-dark-grey=${colors.light-black}
			palette-red=${colors.red}
			palette-green=${colors.green}
			palette-yellow=${colors.yellow}
			palette-blue=${colors.blue}
			palette-magenta=${colors.magenta}
			palette-cyan=${colors.cyan}
			palette-light-red=${colors.light-red}
			palette-light-green=${colors.light-green}
			palette-light-yellow=${colors.light-yellow}
			palette-light-blue=${colors.light-blue}
			palette-light-magenta=${colors.light-magenta}
			palette-light-cyan=${colors.light-cyan}
			palette-white=${colors.white}
			palette-light-grey=${colors.light-white}
			palette-foreground=${colors.foreground}
			palette-background=${colors.background}
		'';
	};


}
