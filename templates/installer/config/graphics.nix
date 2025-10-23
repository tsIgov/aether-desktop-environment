{ ... }:
{
	aether.graphics = {
		nvidia = {
			enable = false;
			drivers = "nvidia";
			prime = {
				enable = true;
				type = "offload";
			};
		};
	};
}
