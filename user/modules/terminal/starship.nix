{ lib, config, aether, ... }:
let 
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	programs.starship = {
		enable = true;
		settings = {
			format = lib.concatStrings [
				"$shell"
				"[](fg:#${palette.surface2} bg:#${palette.surface1})"
				"$directory"
				"[](fg:#${palette.surface1} bg:#${palette.surface0})"
				"$git_branch"
				"$git_status"
				"[ ](fg:#${palette.surface0})"
				"\n$character"
			];
			
			shell = {
				style = "bold bg:#${palette.surface2} fg:#cdd6f4";
				format = "[ $indicator ]($style)";
				disabled = false;
			};

			directory = {
				style = "bold fg:#${palette.accent} bg:#${palette.surface1}";
				format = "[ $path]($style)";
				truncation_length = 3;
				truncation_symbol = "…/";
			};

			git_branch = {
				symbol = "";
				style = "fg:#${palette.complimentary} bg:#${palette.surface0}";
				format = "[ $symbol $branch ]($style)";
			};

			git_status = {
				style = "fg:#${palette.complimentary} bg:#${palette.surface0}";
				format = "[$all_status$ahead_behind]($style)";
			};

			character = {
				success_symbol = "[❯](bold fg:#${palette.accent})";
				error_symbol = "[󰅖](bold fg:#f38ba8)";
			};
		};
	};
}
