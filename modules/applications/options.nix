{
	home = { lib, aether, pkgs, ... }:
	{
		options.aether.applications = with lib; with types; {
			default-apps = {
				terminal = mkOption { type = pathInStore; default = "${pkgs.kitty}/bin/kitty"; };
				fileManager = mkOption { type = pathInStore; default = "${pkgs.nemo}/bin/nemo"; };
			};
		};
	};

}
