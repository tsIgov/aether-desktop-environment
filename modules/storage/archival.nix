{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		file-roller
		p7zip
	];
	hm = {
		wayland.windowManager.hyprland = {
			settings = {
				windowrulev2 = [
					"float, class:(org.gnome.FileRoller), initialTitle:^(.*Compress.*)$"
					"center 1, class:(org.gnome.FileRoller), initialTitle:^(.*Compress.*)$"
					"size 550 160, class:(org.gnome.FileRoller), initialTitle:^(.*Compress.*)$"

					"float, class:(org.gnome.FileRoller), initialTitle:^(.*Extract.*)$"
					"center 1, class:(org.gnome.FileRoller), initialTitle:^(.*Extract.*)$"
					"size 550 160, class:(org.gnome.FileRoller), initialTitle:^(.*Extract.*)$"
				];
			};
		};
	};
}
