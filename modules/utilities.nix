{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			pciutils
			gotop
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
