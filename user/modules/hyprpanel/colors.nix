{ pkgs, config, aetherLib, ... }:
let 
	flavorName = config.aether.appearance.flavor;
	flavor = aetherLib.appearance.flavors.${flavorName};
  	accent = config.aether.appearance.accent;
in
{
	programs.hyprpanel = {
		override.theme = {
			bar = {
				menus = {
					border.color =  "#${flavor.surface0}";
					tooltip = {
						text =  "#${flavor.subtext1}";
						background =  "#${flavor.mantle}";
					};
					dropdownmenu = {
						divider =  "#${flavor.base}";
						text =  "#${flavor.text}";
						background =  "#${flavor.mantle}";
					};
					slider = {
						puck =  "#${flavor.surface2}";
						backgroundhover =  "#${flavor.surface1}";
						background =  "#${flavor.surface0}";
						primary =  "#${flavor.${accent}}";
					};
					progressbar = {
						background =  "#${flavor.surface0}";
						foreground =  "#${flavor.${accent}}";
					};
					iconbuttons = {
						active =  "#${flavor.${accent}}";
						passive =  "#${flavor.text}";
					};
					buttons = {
						text =  "#${flavor.mantle}";
						disabled =  "#${flavor.surface0}";
						active =  "#${flavor.${accent}}";
						default =  "#${flavor.${accent}}";
					};
					check_radio_button = {
						active =  "#${flavor.${accent}}";
						background =  "#${flavor.surface0}";
					};
					switch = {
						puck =  "#${flavor.surface1}";
						disabled =  "#${flavor.surface0}";
						enabled =  "#${flavor.${accent}}";
					};
					icons = {
						active =  "#${flavor.${accent}}";
						passive =  "#${flavor.text}";
					};
					listitems = {
						active =  "#${flavor.${accent}}";
						passive =  "#${flavor.text}";
					};
					popover = {
						border =  "#${flavor.mantle}";
						background =  "#${flavor.mantle}";
						text =  "#${flavor.text}";
					};
					label =  "#${flavor.text}";
					feinttext =  "#${flavor.subtext0}";
					dimtext =  "#${flavor.subtext1}";
					text =  "#${flavor.text}";
					cards =  "#${flavor.base}";
					background =  "#${flavor.mantle}";
				};

				buttons = {
					style =  "default";
					workspaces = {
						numbered_active_underline_color =  "#${flavor.${accent}}";
						hover =  "#${flavor.${accent}}";
						active =  "#${flavor.${accent}}";
						occupied =  "#${flavor.${accent}}";
						available =  "#${flavor.subtext0}";
						background =  "#${flavor.mantle}";
					};
					icon =  "#${flavor.${accent}}";
					text =  "#${flavor.text}";
					hover =  "#${flavor.surface1}";
					icon_background =  "#${flavor.mantle}";
					background =  "#${flavor.mantle}";
					borderColor =  "#${flavor.surface0}";
				};
				background =  "#${flavor.mantle}";
				border.color =  "#${flavor.surface0}";
			};

			osd = {
				label =  "#${flavor.text}";
				icon =  "#${flavor.${accent}}";
				bar_overflow_color =  "#${flavor.red}";
				bar_empty_color =  "#${flavor.surface0}";
				bar_color =  "#${flavor.${accent}}";
				border.color =  "#${flavor.surface0}";
				icon_container =  "#${flavor.mantle}";
				bar_container =  "#${flavor.mantle}";
			};
			notification = {
				close_button.label =  "#${flavor.surface2}";
				close_button.background =  "#${flavor.surface0}";
				labelicon =  "#${flavor.${accent}}";
				text =  "#${flavor.text}";
				time =  "#${flavor.subtext0}";
				border =  "#${flavor.surface0}";
				label =  "#${flavor.${accent}}";
				actions.text =  "#${flavor.mantle}";
				actions.background =  "#${flavor.${accent}}";
				background =  "#${flavor.base}";
			};
		};
	};
}