{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			swaylock-effects
		];

		security.pam.services.swaylock = {};
	};

	home = { ... }:
	{
		home.file = {
			".config/swaylock/config".text = ''screenshots
clock
indicator
indicator-radius=100
indicator-thickness=2
effect-blur=7x5
ring-color=bb00cc
key-hl-color=880033
line-color=00000000
inside-color=00000088
separator-color=00000000
fade-in=0.2'';
		};
	};
	
}