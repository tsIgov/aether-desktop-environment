{ pkgs, ... }:
let
	bash = "${pkgs.bash}/bin/bash";
	hyprctl = "${pkgs.hyprland}/bin/hyprctl";
	jq = "${pkgs.jq}/bin/jq";
	awk = "${pkgs.gawk}/bin/gawk";
in
{
	environment.etc."aether/window-manager/scripts/change-workspace.sh" = {
		source = pkgs.replaceVars ./change-workspace.sh {
			inherit bash hyprctl jq;
		};
		mode = "0555";
	};

	environment.etc."aether/window-manager/scripts/toggle-group.sh" = {
		source = pkgs.replaceVars ./toggle-group.sh {
			inherit bash hyprctl jq;
		};
		mode = "0555";
	};

	environment.etc."aether/window-manager/scripts/add-master.sh" = {
		source = pkgs.replaceVars ./add-master.sh {
			inherit bash hyprctl jq;
		};
		mode = "0555";
	};

	environment.etc."aether/window-manager/scripts/move.sh" = {
		source = pkgs.replaceVars ./move.sh {
			inherit bash hyprctl jq;
		};
		mode = "0555";
	};

	environment.etc."aether/window-manager/scripts/quick-move.sh" = {
		source = pkgs.replaceVars ./quick-move.sh {
			inherit bash hyprctl jq awk;
		};
		mode = "0555";
	};

	environment.etc."aether/window-manager/scripts/quick-toggle.sh" = {
		source = pkgs.replaceVars ./quick-toggle.sh {
			inherit bash hyprctl jq awk;
		};
		mode = "0555";
	};

	environment.etc."aether/window-manager/scripts/resize.sh" = {
		source = pkgs.replaceVars ./resize.sh {
			inherit bash hyprctl jq;
		};
		mode = "0555";
	};

	environment.etc."aether/window-manager/scripts/toggle-floating-focus.sh" = {
		source = pkgs.replaceVars ./toggle-floating-focus.sh {
			inherit bash hyprctl jq;
		};
		mode = "0555";
	};
}
