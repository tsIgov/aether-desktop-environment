{ config, lib, ... }:
let 
	cfg = config.aether.system.nvidia;
in
{
	config = lib.mkIf (cfg == "disabled") {
		boot.blacklistedKernelModules = [
			"nvidia"
			"nvidiafb"
			"nvidia-drm"
			"nvidia-uvm"
			"nvidia-modeset"
			"nouveau"
		];
	};
}