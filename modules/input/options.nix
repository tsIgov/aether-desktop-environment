{
	home = { lib, aether, pkgs, ... }:
	{
		options.aether.input = with lib; with types; {
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
	};
}
