{ pkgs, ... }:
{
	services.udisks2.enable = true;

	environment.systemPackages = with pkgs; [
		gvfs
		gnome-disk-utility
		ffmpegthumbnailer
		webp-pixbuf-loader
	];

	hm = {
		services.udiskie = {
			enable = true;
			automount = true;
			notify = false;
			tray = "never";
		};
	};
}
