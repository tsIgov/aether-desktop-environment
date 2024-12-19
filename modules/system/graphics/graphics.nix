{ pkgs, lib, ... }:

let
	script = builtins.readFile ./getGraphicsControllers.sh;
	controllersJSON = pkgs.runCommand "getGraphicsControllers" { nativeBuildInputs = [ pkgs.pciutils ]; } script;
	controllers = builtins.fromJSON (builtins.readFile controllersJSON);
in
{
	hardware.graphics.enable = true;

	hardware.nvidia = lib.mkIf (controllers.nvidia != "") {
		modesetting.enable = true;
		powerManagement.enable = true;
		powerManagement.finegrained = false;
		open = false;
		nvidiaSettings = false;

		prime =lib.mkIf (controllers.amd != "" || controllers.intel != "") {
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
			intelBusId = controllers.intel;
			nvidiaBusId = controllers.nvidia;
			amdgpuBusId = controllers.amd;
		};
	};

	services.xserver.videoDrivers = lib.mkIf (controllers.nvidia != "") ["nvidia"];
	environment.sessionVariables = lib.mkIf (controllers.nvidia != "") {
		"LIBVA_DRIVER_NAME" = "nvidia";
		"__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
	};
}