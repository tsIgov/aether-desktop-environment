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
			gedit
    		hyprpicker
			hyprshot
		];
	};

}
