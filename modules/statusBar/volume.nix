{
	home = { pkgs, config, ... }:
	{
		programs.hyprpanel = {
			settings = {
				bar.volume = {
					label = false;
					middleClick = "${pkgs.pulsemixer}/bin/pulsemixer --toggle-mute --id $(${pkgs.pulsemixer}/bin/pulsemixer --list-sources | grep Default | cut -d ',' -f 1 | cut -d ' ' -f 3)";
					rightClick = "${config.aether.defaultApps.terminal} ${pkgs.pulsemixer}/bin/pulsemixer";
					scrollDown = "${pkgs.hyprpanel}/bin/hyprpanel 'vol -5'";
					scrollUp = "${pkgs.hyprpanel}/bin/hyprpanel 'vol +5'";
				};

				menus.volume.raiseMaximumVolume = false;

				theme.osd = {
					enable = true;
					active_monitor = true;
					border.size = "0.1em";
					duration = 2500;
					location = "right";
					margins = "0 2rem 0 0";
					muted_zero = true;
					opacity = 100;
					orientation = "vertical";
					radius = "1rem";
					scaling = 100;
				};
			};
		};
	};
}
