{ pkgs, lib, ... }:

{
	options = with lib; with types; {
		directories = {
			screenshot = mkOption { type = str; default = "~/Screenshots"; };
		};
	};

	config = {
		home.packages = with pkgs; [
			hyprshot
		];
	};
}
