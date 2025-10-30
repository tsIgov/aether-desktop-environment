{ ... }:
{
	boot = {
		initrd.verbose = false;
		consoleLogLevel = 3;
		kernelParams = [ "quiet" "udev.log_level=3" ];
	};
}
