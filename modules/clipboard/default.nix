{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			clipse
			wl-clipboard
			wl-clip-persist
		];
	};

	home = { pkgs, config, aether, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		wayland.windowManager.hyprland = {
			settings.exec-once = [
				"${pkgs.clipse}/bin/clipse -listen"
				"${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular"
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
