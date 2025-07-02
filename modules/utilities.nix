{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			pciutils
			gotop
			playerctl
			sysstat
			nwg-displays # monitor layout tool
			jq
		];
	};

	home = { pkgs, ... }:
	{
		home.packages = with pkgs; [
			eog # imaget viewer
			gedit # text editor
    		hyprpicker # color picker
			hyprshot # screenshot utility
			celluloid # multimedia player
			evince # pdf viewer
		];
	};

}
