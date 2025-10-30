{ ... }:
{
	boot = {
		initrd.verbose = false;
		boot.consoleLogLevel = 3;
		boot.kernelParams = [ "quiet" "udev.log_level=3" ];
	};
}
