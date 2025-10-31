{ lib, config, ... }:
let
	palette = config.aether.theme.color-scheme;
in
{
	hm = {
		programs.starship = {
			enable = true;
			enableInteractive = false;
			settings = {
				format = lib.concatStrings [
					"$shell"
					"[](fg:#${palette.surface0} bg:#${palette.background0})"
					"[](fg:#${palette.surface0} bg:#${palette.background0})"
					"$directory"
					"[](fg:#${palette.surface0} bg:#${palette.background0})"
					"[](fg:#${palette.surface0} bg:#${palette.background0})"
					"$git_branch"
					"$git_status"
					"[](fg:#${palette.surface0})"
					"\n$character"
				];

				shell = {
					style = "bold bg:#${palette.surface0} fg:#${palette.foreground0}";
					format = "[ $indicator ]($style)";
					disabled = false;
				};

				directory = {
					style = "bold fg:#${palette.primary} bg:#${palette.surface0}";
					format = "[ $path ]($style)";
					truncation_length = 3;
					truncation_symbol = "…/";
				};

				git_branch = {
					symbol = "";
					style = "fg:#${palette.secondary} bg:#${palette.surface0}";
					format = "[ $symbol $branch ]($style)";
				};

				git_status = {
					style = "fg:#${palette.warning} bg:#${palette.surface0}";
					format = "[$all_status$ahead_behind ]($style)";
				};

				character = {
					success_symbol = "[❯](bold fg:#${palette.primary})";
					error_symbol = "[󰅖](bold fg:#${palette.error})";
				};
			};
		};
	};
}
