{
	system = { pkgs, ... }:
	{
		services.udisks2.enable = true;

		environment.systemPackages = with pkgs; [
			nemo
			file-roller
			p7zip
			gvfs
		];
	};
}