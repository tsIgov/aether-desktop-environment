{ config, aether, ... }:
{
	hm = {
		gtk.iconTheme = {
			name = "aether-icons";
			package = aether.pkgs.icons.override {
				flavor = config.aether.appearance.colors.flavor;
				accent = config.aether.appearance.colors.primary;
			};
		};
	};
}
