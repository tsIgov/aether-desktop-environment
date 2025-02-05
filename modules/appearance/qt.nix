{
	home = { config, pkgs, ... }:
	let 
		flavorName = config.aether.appearance.colors.flavor;
		accent = config.aether.appearance.colors.accent;
	in
	{
		home.packages = with pkgs; [
			qt5.qtwayland
			qt6.qtwayland
			kdePackages.qtstyleplugin-kvantum
		];

		qt = {
			enable = true;
			platformTheme.name = "kvantum";
			style = {
				name = "kvantum";
				package = pkgs.catppuccin-kvantum.override {
					accent =  accent;
					variant = flavorName;
				};
			};
		};

		xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
			General.theme = "catppuccin-${flavorName}-${accent}";
		};
	};

}