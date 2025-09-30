{ pkgs, ... }:
{
	environment.etc = {
		"aether/power/scripts/inhibition-status.sh" = {
			source = pkgs.replaceVars ./inhibition-status.sh {
				bash = "${pkgs.bash}/bin/bash";
				systemctl = "${pkgs.systemd}/bin/systemctl";
			};
			mode = "0555";
		};

		"aether/power/scripts/inhibition-toggle.sh" = {
			source = pkgs.replaceVars ./inhibition-toggle.sh {
				bash = "${pkgs.bash}/bin/bash";
				systemctl = "${pkgs.systemd}/bin/systemctl";
				systemd-run = "${pkgs.systemd}/bin/systemd-run";
			};
			mode = "0555";
		};
	};
}
