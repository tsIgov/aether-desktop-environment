{
	system = { pkgs, ... }:
	{
		security.polkit.enable = true;

		systemd.user.services.polkit-authentication-agent = {
			enable = true;
			description = "Polkit GNOME authentication agent";
			
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
			};

			wantedBy = [ "default.target" ];
		};
	};
}