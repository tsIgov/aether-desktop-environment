
{ pkgs, lib, config, ... }:
{
	programs.rofi = {
		enable = true;
		plugins = with pkgs; [ 
			rofi-calc
		];
		font = "Hack Nerd Font Mono 12";
		location = "center";
		xoffset = 0;
		yoffset = 0;
		theme = "theme";
		extraConfig = {
			modi = "drun,calc,test:rofi-test";
			#icon-theme = "Oranchelo";
			show-icons = true;
			drun-display-format = "{icon} {name}";
			disable-history = true;
			hide-scrollbar = true;
			sidebar-mode = true;
			display-drun = "   Apps ";
			display-run = "   Run ";
			display-window = " 󰕰  Window";
			display-Network = " 󰤨  Network";
			kb-clear-line = "";
		};
	};

	# home.packages = with pkgs; [
	# 	rofimoji
	# 	rofi-systemd
	# 	rofi-pulse-select
	# ];

	home.packages = with pkgs; [
		(writeShellScriptBin "rofi-test" (builtins.readFile ./test.sh))
	];
}