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
			".config/sys64/hud/style.css".source = pkgs.replaceVars ./syshud.css {
				colorBackground = "#${palette.mantle}";
				colorText = "#${palette.text}";
				colorPrimary = "#${palette.primary}";
			};
		};
	};
}
