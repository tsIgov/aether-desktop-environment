{
	home = { lib, ... }:
	let
		inherit (lib) mkOption;
		inherit (lib.types) listOf str bool submodule;
	in
	{
		options.aether.display =  {
			profiles = mkOption {
				default = [];
				description = "";
				type = listOf (submodule {
					options = {
						name = mkOption { type = str; description = ""; };
						monitors = mkOption {
							type = listOf (submodule {
								options = {
									enabled = mkOption { type = bool; default = true; description = ""; };
									name = mkOption { type = str; description = ""; };
									resolution = mkOption { type = str; default = "preferred"; description = ""; };
									position = mkOption { type = str; default = "auto"; description = ""; };
									scale = mkOption { type = str; default = "auto"; description = ""; };
									extraArgs = mkOption { type = str; default = ""; description = ""; };
								};
							});
						};
					};
				});
			};
		};
	};
}
