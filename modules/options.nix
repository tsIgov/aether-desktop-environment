{
	home = { lib, aether, pkgs, ... }:
	{
		options.aether = with lib; with types; {
			input = {
				mouse = {
					sensitivity = mkOption { type = float; default = 0.0; apply = x: if x >= -1.0 && x <= 1.0 then x else throw "mouseSensitivity must be a value between -1 and 1";};
				};

				keyboard = {
					layouts = mkOption {
						type = listOf (submodule {
							options = {
								name = mkOption { type = str; };
								variant = mkOption { type = str; default = ""; };
							};
						});
					};
				};
			};

			defaultApps = {
				terminal = mkOption { type = pathInStore; default = "${pkgs.kitty}/bin/kitty"; };
				fileManager = mkOption { type = pathInStore; default = "${pkgs.nemo}/bin/nemo"; };
			};

		};
	};

}
