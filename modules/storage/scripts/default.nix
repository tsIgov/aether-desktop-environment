{ pkgs, ... }:
{
	environment.etc = {
		"aether/storage/scripts/garbage-collect.sh" = {
			source = pkgs.replaceVars ./garbage-collect.sh {
				bash = "${pkgs.bash}/bin/bash";
				notify-send = "${pkgs.libnotify}/bin/notify-send";
				nix-collect-garbage = "${pkgs.nix}/bin/nix-collect-garbage";
				nix-store = "${pkgs.nix}/bin/nix-store";
			};
			mode = "0555";
		};
	};
}
