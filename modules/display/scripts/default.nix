{ pkgs, ... }:
{
	environment.etc = {
		"aether/display/scripts/auto-profile.sh" = {
			source = pkgs.replaceVars ./auto-profile.sh {
				bash = "${pkgs.bash}/bin/bash";
			};
			mode = "0555";
		};
		"aether/display/scripts/apply-profile.sh" = {
			source = pkgs.replaceVars ./apply-profile.sh {
				bash = "${pkgs.bash}/bin/bash";
				hyprctl = "${pkgs.hyprland}/bin/hyprctl";
				jq = "${pkgs.jq}/bin/jq";
			};
			mode = "0555";
		};
		"aether/display/scripts/fallback-reset.sh" = {
			source = pkgs.replaceVars ./fallback-reset.sh {
				bash = "${pkgs.bash}/bin/bash";
				hyprctl = "${pkgs.hyprland}/bin/hyprctl";
				jq = "${pkgs.jq}/bin/jq";
			};
			mode = "0555";
		};
	};
}
