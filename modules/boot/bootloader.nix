{ ... }:
{
	boot.loader = {
		timeout = 0;
		systemd-boot = {
			enable = true;
			editor = false;
		};

		efi.canTouchEfiVariables = true;
	};
}
