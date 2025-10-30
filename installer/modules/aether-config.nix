{ ... }:
{
	config = {
		aether.connectivity.hostname = "aether-os";
		aether.user.username = "aether";
		aether.user.description = "aether";
	};

	imports = [
		../modules/boot/bootloader.nix
		../modules/boot/logging.nix
		../modules/boot/plymouth.nix

		../modules/connectivity/network.nix

		../modules/system/system.nix
		../modules/system/user.nix
		../modules/system/version.nix

		../modules/terminal/fish.nix
		../modules/terminal/newt.nix
		../modules/terminal/starship.nix
		../modules/terminal/tty.nix

		../modules/appearance/colors.nix
	];

}
