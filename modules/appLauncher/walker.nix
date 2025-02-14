{
	system = { pkgs, ... }:
	{

		environment.systemPackages = with pkgs; [
			walker
			libqalculate
		];

	};


	home = { pkgs, ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				exec-once = walker --gapplication-service
			'';
		};
	};
}
