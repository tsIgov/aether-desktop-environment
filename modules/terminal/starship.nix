{ lib, config, aether, ... }:
let
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	hm = {
		programs.starship = {
			enable = true;
			settings = {
				format = lib.concatStrings [
					"$shell"
					"[](fg:#${palette.surface0} bg:#${palette.base})"
					"[](fg:#${palette.surface0} bg:#${palette.base})"
					"$directory"
					"[](fg:#${palette.surface0} bg:#${palette.base})"
					"[](fg:#${palette.surface0} bg:#${palette.base})"
					"$git_branch"
					"$git_status"
					"[](fg:#${palette.surface0})"
					"\n$character"
				];

				shell = {
					style = "bold bg:#${palette.surface0} fg:#${palette.text}";
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
					style = "fg:#${palette.tertiary} bg:#${palette.surface0}";
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
