{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		polkit_gnome
      	swaylock-effects
	];

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

  	services.gnome.gnome-keyring.enable = true;

	security.pam.services.swaylock = {};
}