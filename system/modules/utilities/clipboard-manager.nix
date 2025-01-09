{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		wl-clipboard
		clipse
	];

	systemd.user.services.clipse = {
		enable = true;
		wantedBy = [ "default.target" ];
		description = "Clipse clipboard manager";
		serviceConfig = {
			Type = "simple";
			ExecStart = "${pkgs.clipse}/bin/clipse -listen";
			Restart = "on-failure";
			RestartSec = 1;
		};
	};
}