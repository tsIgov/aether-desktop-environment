{ config, lib, pkgs, ... }:
let 
	cfg = config.aether.system.nvidia;
in
{
	config = lib.mkIf (cfg == "offload") (
		let
			script = builtins.readFile ./getGraphicsControllers.sh;
			controllersJSON = pkgs.runCommand "getGraphicsControllers" { nativeBuildInputs = [ pkgs.pciutils ]; } script;
			controllers = builtins.fromJSON (builtins.readFile controllersJSON);
		in
		{
			hardware.nvidia = {
				modesetting.enable = true;
				powerManagement.enable = true;
				powerManagement.finegrained = false;
				open = true;
				nvidiaSettings = true;

				prime = {
					offload = {
						enable = true;
						enableOffloadCmd = true;
					};
					intelBusId = controllers.intel;
					nvidiaBusId = controllers.nvidia;
					amdgpuBusId = controllers.amd;
				};
			};

			services.xserver.videoDrivers = [ "nvidia" ];
		}
	);
}