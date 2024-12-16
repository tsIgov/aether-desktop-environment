{ pkgs, ... }:

{
	home.packages = with pkgs; [
		wl-clipboard
		clipse
	];

	home.file = {
		".config/clipse/config.json".source = ./config.json;
	};
}
