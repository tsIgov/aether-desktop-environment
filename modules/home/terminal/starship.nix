{ ... }:

{
	programs.starship = {
		enable = true;
	};
	#programs.starship.settings = { };

	home.file = {
		".config/starship.toml".source = ./starship.toml;
	};
}
