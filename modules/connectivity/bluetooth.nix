{ pkgs, ... }:
{
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings = {
			General = {
				Experimental = true;
			};
		};
	};

	environment.systemPackages = with pkgs; [
		bluetui
	];

	hm = {
		wayland.windowManager.hyprland = {
			settings = {
				windowrulev2 = [
					"float, class:(bluetui)"
					"center 1, class:(bluetui)"
					"size 700 500, class:(bluetui)"
				];
			};
		};
	};
}
