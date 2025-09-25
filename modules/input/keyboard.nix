{ config, lib, ... }:
let
	cfg = config.aether.input.keyboard;
	kblayouts = lib.strings.concatStringsSep "," (builtins.map (layout: layout.name) cfg.layouts);
	kbvariants = lib.strings.concatStringsSep "," (builtins.map (layout: layout.variant) cfg.layouts);
in
{
	options.aether.input.keyboard = with lib; with types; {
		layouts = mkOption {
			type = listOf (submodule {
				options = {
					name = mkOption { type = str; };
					variant = mkOption { type = str; default = ""; };
				};
			});
		};
	};

	config = {
		hm = {
			wayland.windowManager.hyprland = {
				settings.input = {
					kb_layout = kblayouts;
					kb_variant = kbvariants;
					kb_options = "grp:caps_toggle";
					numlock_by_default = true;
				};
			};
		};
	};
}
