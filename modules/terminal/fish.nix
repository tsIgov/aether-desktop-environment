{ config, aether, ... }:
let
	palette = config.aether.theme.color-scheme;
in
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
			set fish_color_autosuggestion      	${palette.foreground1}
			set fish_color_command             	${palette.primary}
			set fish_color_comment             	${palette.foreground2}
			set fish_color_end                 	${palette.primary}
			set fish_color_error               	${palette.error}
			set fish_color_escape              	${palette.warning}
			set fish_color_keyword				${palette.primary}
			set fish_color_operator				${palette.foreground0}
			set fish_color_option            	${palette.foreground0}
			set fish_color_param              	${palette.secondary}
			set fish_color_quote               	${palette.foreground0}
			set fish_color_redirection         	${palette.foreground0}

			eval $(starship init fish)
		'';
	};
}
