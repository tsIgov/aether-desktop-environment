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
				description = "When connecting or disconnecting monitors, the system will try to match a profile and set the monitors accordingly. For a profile to be matched all of its monitors must match an phisical and there should be not physical monitors unmatched.";
				type = listOf (submodule {
					options = {
						monitors = mkOption {
							type = listOf (submodule {
								options = {
									enabled = mkOption { type = bool; default = true; description = "Whether or not the monitor should be enabled when this profile is active."; };
									name = mkOption { type = str; description = "A regex to match the name of the monitor."; example = "DP-[1-9]"; };
									resolution = mkOption { type = str; default = "preferred"; description = "The resolution of the monitor in Hyprland format. See https://wiki.hypr.land/Configuring/Monitors/"; example = "1920x1080@144"; };
									position = mkOption { type = str; default = "preferred"; description = "The position of the monitor in Hyprland format. See https://wiki.hypr.land/Configuring/Monitors/"; example = "1920x0"; };
									scale = mkOption { type = str; default = "auto"; description = "The scale of the monitor in Hyprland format. See https://wiki.hypr.land/Configuring/Monitors/"; example = "1"; };
									extraArgs = mkOption { type = str; default = ""; description = "Unformatted arguments that will be added at the end of the monitor rule. See https://wiki.hypr.land/Configuring/Monitors/"; example = "mirror, DP-2"; };
								};
							});
						};
					};
				});
			};
		};
	};
}
