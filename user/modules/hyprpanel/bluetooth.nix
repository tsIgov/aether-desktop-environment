{ pkgs, ... }:
{
	programs.hyprpanel = {
		settings = {
			bar.bluetooth = {
				label = false;
				rightClick = "${pkgs.overskride}/bin/overskride";
			};
		};
	};
}