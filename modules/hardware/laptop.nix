{
	system = { pkgs, lib, config, ... }:
	let
		enabled = config.aether.hardware.laptop;
	in
	{
		environment.systemPackages = with pkgs; lib.mkIf enabled [
			brightnessctl
		];

		services = lib.mkIf enabled {
			upower.enable = true;
			power-profiles-daemon.enable = true;
		};

	};
}
