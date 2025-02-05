{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			file-roller
			p7zip
		];
	};
}
