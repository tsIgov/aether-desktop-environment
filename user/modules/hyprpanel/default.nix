{ pkgs, aether, ... }:
{
	imports = [ aether.inputs.hyprpanel.homeManagerModules.hyprpanel ];

	programs.hyprpanel = {

		enable = true;
		hyprland.enable = true;
		overlay.enable = true;
		overwrite.enable = true;

		settings = {
			hyprpanel = {
				restartAgs = true;
				restartCommand = "${pkgs.hyprpanel}/bin/hyprpanel q; ${pkgs.hyprpanel}/bin/hyprpanel";
			};

			scalingPriority = "gdk";
			tear = false;
			terminal = "$TERM";

			theme = {
				font = {
					name = aether.lib.appearance.fonts.mono;
					size = "1rem";
					weight = 600;
				};
				
				tooltip.scaling = 90;
			};
		};
	};
}