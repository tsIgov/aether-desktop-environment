{ pkgs, lib, ... }:
{
	boot.blacklistedKernelModules = [
		"nvidia"
		"nvidiafb"
		"nvidia-drm"
		"nvidia-uvm"
		"nvidia-modeset"
		"nouveau"
	];
}
