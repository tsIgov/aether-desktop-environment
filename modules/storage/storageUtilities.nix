{
	system = { pkgs, ... }:
	{
		services.udisks2.enable = true;

		environment.systemPackages = with pkgs; [
			gvfs
			gnome-disk-utility
		];
	};

	home = { ... }:
	{
		services.udiskie = {
			enable = true;
			automount = true;
			notify = false;
			tray = "never";
		};
	};
}
