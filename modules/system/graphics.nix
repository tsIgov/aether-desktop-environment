{ config, lib, ... }:

let
  cfg = config.aether.system.graphics;
in
{
	options = with lib; with types;{
		aether.system.graphics = {
			nvidia = mkOption { type = lib.types.bool; description = "Enables Nvidia specific settings"; };
		};
	};

	config = lib.mkIf (cfg.nvidia == true) {

		hardware.graphics.enable = true;

		hardware.nvidia = {
			modesetting.enable = true;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};

		services.xserver.videoDrivers = ["nvidia"];

		environment.sessionVariables = {
			WLR_NO_HARDWARE_CURSORS = "1";
		};
	};
}