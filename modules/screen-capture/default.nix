{ pkgs, ... }:
{
	environment.etc."aether/screen-capture/scripts".source = ./scripts;

	environment.systemPackages = with pkgs; [
		hyprshot
		satty
	];

	hm = {
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = , PRINT, exec, sh /etc/aether/screen-capture/scripts/screen-capture-menu.sh
			'';
		};
	};
}
