{ pkgs, ... }:
{
	environment.etc."aether/bluetooth/scripts".source = ./scripts;

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
		overskride
	];
}
