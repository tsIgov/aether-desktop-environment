{
	system = { lib, config, ... }:
	let
		cfg = config.aether.virtualization.docker;
	in
	{
		config = lib.mkIf (cfg.enable) {
			virtualisation.docker = {
				enable = true;
				rootless = {
					enable = true;
					setSocketVariable = true;
				};
			};
		};
	};
}
