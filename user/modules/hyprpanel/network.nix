{ pkgs, config, ... }:
{
	programs.hyprpanel = {
		settings = {
			bar.network = {
				label = false;
				rightClick = "${config.aether.defaultApps.terminal} ${pkgs.networkmanager}/bin/nmtui";
			};
		};
	};
}