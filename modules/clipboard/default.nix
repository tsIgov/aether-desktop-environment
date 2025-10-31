{ pkgs, config, aether, ... }:
{
	environment.systemPackages = with pkgs; [
		clipse
		wl-clipboard
		wl-clip-persist
	];

	hm = {
		wayland.windowManager.hyprland = {
			settings.exec-once = [
				"${pkgs.clipse}/bin/clipse -listen"
				"${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular"
			];

			settings.windowrulev2 = [
				"float,class:(clipse)"
				"center,class:(clipse)"
				"size 700 80%,class:(clipse)"
			];

			extraConfig = ''
				bind = SUPER, V, exec, pkill clipse || kitty --class clipse clipse
				bind = SUPER SHIFT, V, exec, clipse -clear
			'';
		};

		home.file = {
			".config/clipse/config.json".source = ./config.json;
		};
	};
}
