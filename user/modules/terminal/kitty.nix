{ config, aether, ... }:
let 
	flavorName = config.aether.appearance.flavor;
	flavor = aether.lib.appearance.flavors.${flavorName};
  	accent = config.aether.appearance.accent;
in
{
	programs.kitty = {
		enable = true;
		font = {
			name = aether.lib.appearance.fonts.mono;
			size = 11;

		};
		settings = {
			shell = "fish";
			strip_trailing_spaces = "smart";
			window_padding_width = 25;

			foreground ="#${flavor.text}";
			background = "#${flavor.base}";
			selection_foreground = "#${flavor.base}";
			selection_background = "#${flavor.${accent}}";

			cursor = "#f5e0dc";
			cursor_text_color = "#1e1e2e";

			url_color = "#f5e0dc";
			url_style = "straight";

			active_border_color = "#b4befe";
			inactive_border_color = "#6c7086";
			bell_border_color = "#f9e2af";

			active_tab_foreground = "#11111b";
			active_tab_background = "#cba6f7";
			inactive_tab_foreground = "#cdd6f4";
			inactive_tab_background = "#181825";
			tab_bar_background = "#11111b";

			mark1_foreground = "#1e1e2e";
			mark1_background = "#b4befe";
			mark2_foreground = "#1e1e2e";
			mark2_background = "#cba6f7";
			mark3_foreground = "#1e1e2e";
			mark3_background = "#74c7ec";

			# The 16 terminal colors

			# black
			color0 = "#45475a";
			color8 = "#585b70";

			# red
			color1 = "#f38ba8";
			color9 = "#f38ba8";

			# green
			color2 = "#a6e3a1";
			color10 = "#a6e3a1";

			# yellow
			color3 = "#f9e2af";
			color11 = "#f9e2af";

			# blue
			color4 = "#89b4fa";
			color12 = "#89b4fa";

			# magenta
			color5 = "#f5c2e7";
			color13 = "#f5c2e7";

			# cyan
			color6 = "#94e2d5";
			color14 = "#94e2d5";

			# white
			color7 = "#bac2de";
			color15 = "#a6adc8";
		};
		keybindings = {
			"clear_all_shortcuts" = "yes";

			"ctrl+c" = "copy_and_clear_or_interrupt";
			"ctrl+v" = "paste_from_clipboard";

			"ctrl+up" = "scroll_line_up";
			"ctrl+down" = "scroll_line_down";
			"page_up" = "scroll_page_up";
			"page_down" = "scroll_page_down";
			"ctrl+home" = "scroll_home";
			"ctrl+end" = "scroll_end";
			"alt+up" = "scroll_to_prompt -1";
			"alt+down" = "scroll_to_prompt 1";

			"ctrl+shift+equal" = "change_font_size all +1.0";
			"ctrl+shift+plus" = "change_font_size all +1.0";
			"ctrl+shift+kp_add" = "change_font_size all +1.0";
			"ctrl+shift+minus" = "change_font_size all -1.0";
			"ctrl+shift+kp_subtract" = "change_font_size all -1.0";
		};
	};
}