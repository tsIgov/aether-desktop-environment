{ pkgs, ... }:
{
	programs.hyprpanel = {
		settings = {
			bar.network = {
				label = false;
				rightClick = "${pkgs.foot}/bin/foot ${pkgs.networkmanager}/bin/nmtui";
			};
		};
	};
}