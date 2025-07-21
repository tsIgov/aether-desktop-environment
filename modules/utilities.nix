{
	home = { pkgs, ... }:
	{
		home.packages = with pkgs; [
			eog # imaget viewer
			gedit # text editor
    		hyprpicker # color picker
			celluloid # multimedia player
			evince # pdf viewer
		];
	};

}
