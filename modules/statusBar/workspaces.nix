{
	home = { pkgs, ... }:
	{
		programs.hyprpanel = {
			settings = {
				bar.workspaces = {
					applicationIconEmptyWorkspace = "";
					applicationIconFallback = "";
					applicationIconOncePerWorkspace = true;
					icons.active = "";
					icons.available = "";
					icons.occupied = "";
					ignored = "^-.*";
					monitorSpecific = false;
					numbered_active_indicator = "underline";
					reverse_scroll = true;
					scroll_speed = 1;
					showAllActive = false;
					showApplicationIcons = true;
					showWsIcons = true;
					show_icons = false;
					show_numbered = false;
					spacing = 1;
					workspaceMask = false;
					workspaces = 10;
				};

				theme.bar.buttons.workspaces = {
					fontSize = "1.2em";
					pill.active_width = "12em";
					pill.height = "4em";
					pill.radius = "1em";
					pill.width = "4em";
					smartHighlight = true;
					spacing = "0.2em";
				};

			};
		};
	};
}
