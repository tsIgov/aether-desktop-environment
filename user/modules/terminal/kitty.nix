{ config, aether, ... }:
let 
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	programs.kitty = {
		enable = true;
		font = {
			name = config.aether.appearance.fonts.mono;
			size = config.aether.appearance.fonts.size;
		};

		settings = {
			shell = "fish";
			strip_trailing_spaces = "smart";
			window_padding_width = 25;
			confirm_os_window_close = 0;

			foreground ="#${palette.text}";
			background = "#${palette.base}";
			selection_foreground = "#${palette.base}";
			selection_background = "#${palette.accent}";

			cursor = "#${palette.accent}";
			cursor_text_color = "#${palette.crust}";

			url_color = "#${palette.blue}";
			url_style = "straight";

			mark1_foreground = "#${palette.crust}";
			mark1_background = "#${palette.lavender}";
			mark2_foreground = "#${palette.crust}";
			mark2_background = "#${palette.mauve}";
			mark3_foreground = "#${palette.crust}";
			mark3_background = "#${palette.sapphire}";

			# The 16 terminal colors

			# black
			color0 = "#${palette.surface1}";
			color8 = "#${palette.surface2}";

			# red
			color1 = "#${palette.red}";
			color9 = "#${palette.red}";

			# green
			color2 = "#${palette.green}";
			color10 = "#${palette.green}";

			# yellow
			color3 = "#${palette.yellow}";
			color11 = "#${palette.yellow}";

			# blue
			color4 = "#${palette.blue}";
			color12 = "#${palette.blue}";

			# magenta
			color5 = "#${palette.mauve}";
			color13 = "#${palette.mauve}";

			# cyan
			color6 = "#${palette.sky}";
			color14 = "#${palette.sky}";

			# white
			color7 = "#${palette.subtext1}";
			color15 = "#${palette.subtext0}";
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