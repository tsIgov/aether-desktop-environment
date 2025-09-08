{ aether, config, pkgs, ... }:
let
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	hm = {
		home.packages = with pkgs; [
			syshud
		];

		wayland.windowManager.hyprland = {
			settings.exec-once = [
				"${pkgs.syshud}/bin/syshud -p right -o v -m \"0 10 0 0\""
			];
		};

		home.file = {
			".config/sys64/hud/style.css".text = ''
				#syshud {
					background: transparent;
				}

				#syshud .box_layout {
					background: #${palette.mantle};
					border-radius: 25px;
					border: 1px solid @borders;
					margin: 10px;
				}

				#syshud scale {
					margin: 0px;
					padding: 0px;
				}
				#syshud label {
					color: #${palette.text};
				}

				/* Horizontal layout */
				#syshud scale.horizontal {
					padding: 0px;
					min-height: 5px;
				}
				#syshud scale.horizontal trough {
					border-radius: 3px;
					background: alpha(currentColor, 0.1);
					min-height: 5px;
					padding: 0px;
				}
				#syshud scale.horizontal highlight {
					border-radius: 3px;
					min-height: 5px;
					background: #${palette.primary};
					margin: 0px;
				}
				#syshud scale.horizontal slider {
					margin: 0px;
					background: transparent;
					min-height: 5px;
					box-shadow: none;
					padding: 0px;
				}

				/* Vertical layout */
				#syshud scale.vertical {
					padding: 0px;
					min-width: 5px;
				}
				#syshud scale.vertical trough {
					border-radius: 3px;
					background: alpha(currentColor, 0.1);
					min-width: 5px;
					padding: 0px;
				}
				#syshud scale.vertical highlight {
					border-radius: 3px;
					min-width: 5px;
					background: #${palette.primary};
					margin: 0px;
				}
				#syshud scale.vertical slider {
					margin: 0px;
					background: transparent;
					min-width: 5px;
					box-shadow: none;
					padding: 0px;
				}

				/* Levels */
				#syshud .muted {
				}
				#syshud .low {
				}
				#syshud .medium {
				}
				#syshud .high {
				}
			'';
		};
	};
}
