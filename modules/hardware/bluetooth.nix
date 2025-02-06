{
	system = { pkgs, ... }:
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
			overskride
		];
	};
}