{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			file-roller
			p7zip
		];
	};
	home = { ... }:
	{
		wayland.windowManager.hyprland = {
			settings = {
				windowrulev2 = [
					"float, class:(org.gnome.FileRoller), initialTitle:^(.*Compress.*)$"
					"center, class:(org.gnome.FileRoller), initialTitle:^(.*Compress.*)$"
					"size 550 160, class:(org.gnome.FileRoller), initialTitle:^(.*Compress.*)$"

					"float, class:(org.gnome.FileRoller), initialTitle:^(.*Extract.*)$"
					"center, class:(org.gnome.FileRoller), initialTitle:^(.*Extract.*)$"
					"size 550 160, class:(org.gnome.FileRoller), initialTitle:^(.*Extract.*)$"
				];
			};
		};
	};
}
