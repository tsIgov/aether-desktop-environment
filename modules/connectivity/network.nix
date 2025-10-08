{ pkgs, config, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str;

	cfg = config.aether.connectivity;
in
{
	options = {
		aether.connectivity = {
			hostname = mkOption { type = str; };
		};
	};

	config = {
		environment.systemPackages = with pkgs; [
			impala
		];

		networking = {
			hostName = cfg.hostname;
			wireless.iwd.settings = {
				IPv6 = {
					Enabled = true;
				};
				Settings = {
					AutoConnect = true;
				};
			};

			networkmanager.wifi.backend = "iwd";
			networkmanager.enable = true;
		};

		hm = {
			wayland.windowManager.hyprland = {
				settings = {
					windowrulev2 = [
						"float, class:(impala)"
						"center 1, class:(impala)"
						"size 700 800, class:(impala)"
					];
				};
			};
		};
	};
}
