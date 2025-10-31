{ pkgs, config, aether, ... }:
let
	palette = config.aether.theme.color-scheme;
	hexToRgb = aether.lib.colorUtils.hexToRgb;
	colors = {
		background = hexToRgb { hex = palette.background0; };
		foreground = hexToRgb { hex = palette.foreground0; };

		black = hexToRgb { hex = palette.surface0; };
		light-black = hexToRgb { hex = palette.surface0; };

		white = hexToRgb { hex = palette.foreground0; };
		light-white = hexToRgb { hex = palette.foreground0; };

		red = hexToRgb { hex = palette.red; };
		green = hexToRgb { hex = palette.green; };
		yellow = hexToRgb { hex = palette.yellow; };
		blue = hexToRgb { hex = palette.blue; };
		magenta = hexToRgb { hex = palette.magenta; };
		cyan = hexToRgb { hex = palette.cyan; };

		light-red = hexToRgb { hex = palette.red; };
		light-green = hexToRgb { hex = palette.green; };
		light-yellow = hexToRgb { hex = palette.yellow; };
		light-blue = hexToRgb { hex = palette.blue; };
		light-magenta = hexToRgb { hex = palette.magenta; };
		light-cyan = hexToRgb { hex = palette.cyan; };
	};
in
{
	console.enable = false;

	services.kmscon = {
		enable = true;
		fonts = [ { name = config.aether.theme.fonts.mono; package = pkgs.nerd-fonts.hack; } ];
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
