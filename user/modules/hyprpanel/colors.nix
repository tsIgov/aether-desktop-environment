{ pkgs, config, aether, ... }:
let 
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	programs.hyprpanel = {
		override.theme = {
			bar = {
				menus = {
					border.color =  "#${palette.surface0}";
					tooltip = {
						text =  "#${palette.subtext1}";
						background =  "#${palette.mantle}";
					};
					dropdownmenu = {
						divider =  "#${palette.base}";
						text =  "#${palette.text}";
						background =  "#${palette.mantle}";
					};
					slider = {
						puck =  "#${palette.surface2}";
						backgroundhover =  "#${palette.surface1}";
						background =  "#${palette.surface0}";
						primary =  "#${palette.accent}";
					};
					progressbar = {
						background =  "#${palette.surface0}";
						foreground =  "#${palette.accent}";
					};
					iconbuttons = {
						active =  "#${palette.accent}";
						passive =  "#${palette.text}";
					};
					buttons = {
						text =  "#${palette.mantle}";
						disabled =  "#${palette.surface0}";
						active =  "#${palette.accent}";
						default =  "#${palette.accent}";
					};
					check_radio_button = {
						active =  "#${palette.accent}";
						background =  "#${palette.surface0}";
					};
					switch = {
						puck =  "#${palette.surface1}";
						disabled =  "#${palette.surface0}";
						enabled =  "#${palette.accent}";
					};
					icons = {
						active =  "#${palette.accent}";
						passive =  "#${palette.text}";
					};
					listitems = {
						active =  "#${palette.accent}";
						passive =  "#${palette.text}";
					};
					popover = {
						border =  "#${palette.mantle}";
						background =  "#${palette.mantle}";
						text =  "#${palette.text}";
					};
					label =  "#${palette.text}";
					feinttext =  "#${palette.subtext0}";
					dimtext =  "#${palette.subtext1}";
					text =  "#${palette.text}";
					cards =  "#${palette.base}";
					background =  "#${palette.mantle}";
				};

				buttons = {
					style =  "default";
					workspaces = {
						numbered_active_underline_color =  "#${palette.accent}";
						hover =  "#${palette.accent}";
						active =  "#${palette.accent}";
						occupied =  "#${palette.accent}";
						available =  "#${palette.subtext0}";
						background =  "#${palette.mantle}";
					};
					icon =  "#${palette.accent}";
					text =  "#${palette.text}";
					hover =  "#${palette.surface1}";
					icon_background =  "#${palette.mantle}";
					background =  "#${palette.mantle}";
					borderColor =  "#${palette.surface0}";
				};
				background =  "#${palette.mantle}";
				border.color =  "#${palette.surface0}";
			};

			osd = {
				label =  "#${palette.text}";
				icon =  "#${palette.accent}";
				bar_overflow_color =  "#${palette.red}";
				bar_empty_color =  "#${palette.surface0}";
				bar_color =  "#${palette.accent}";
				border.color =  "#${palette.surface0}";
				icon_container =  "#${palette.mantle}";
				bar_container =  "#${palette.mantle}";
			};
			notification = {
				close_button.label =  "#${palette.surface2}";
				close_button.background =  "#${palette.surface0}";
				labelicon =  "#${palette.accent}";
				text =  "#${palette.text}";
				time =  "#${palette.subtext0}";
				border =  "#${palette.surface0}";
				label =  "#${palette.accent}";
				actions.text =  "#${palette.mantle}";
				actions.background =  "#${palette.accent}";
				background =  "#${palette.base}";
			};
		};
	};
}