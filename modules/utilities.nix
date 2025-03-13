{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			pciutils
			gotop
			playerctl
		];
	};

	home = { pkgs, ... }:
	{
		home.packages = with pkgs; [
			gedit # text editor
    		hyprpicker # color picker
			hyprshot # screenshot utility
			celluloid # multimedia player
			evince # pdf viewer
		];
	};

}
