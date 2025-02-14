{
	home = { pkgs, ... }:
	{
		programs.hyprpanel = {
			settings = {
				bar.customModules = {
					kbLayout = {
						icon = "";
						label = true;
						labelType = "code";
					};

					submap = {
						disabledIcon = "";
						enabledIcon = "󰌌";
						label = false;
						showSubmapName = false;
					};
				};

				theme.bar.buttons.modules = {
					kbLayout.spacing = "0";
					submap.spacing = "0";
				};
			};
		};
	};
}
