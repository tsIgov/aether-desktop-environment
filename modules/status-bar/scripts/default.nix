{ pkgs, ... }:
{
	environment.etc = {
		"aether/status-bar/scripts/disk.sh" = {
			source = pkgs.replaceVars ./disk.sh {
				bash = "${pkgs.bash}/bin/bash";
			};
			mode = "0555";
		};

		"aether/status-bar/scripts/idle.sh" = {
			source = pkgs.replaceVars ./idle.sh {
				bash = "${pkgs.bash}/bin/bash";
			};
			mode = "0555";
		};

		"aether/status-bar/scripts/power-profile.sh" = {
			source = pkgs.replaceVars ./power-profile.sh {
				bash = "${pkgs.bash}/bin/bash";
				systemd-ac-power = "${pkgs.systemd}/bin/systemd-ac-power";
			};
			mode = "0555";
		};

		"aether/status-bar/scripts/system.sh" = {
			source = pkgs.replaceVars ./system.sh {
				bash = "${pkgs.bash}/bin/bash";
				mpstat = "${pkgs.sysstat}/bin/mpstat";
				free = "${pkgs.procps}/bin/free";
			};
			mode = "0555";
		};
	};
}
