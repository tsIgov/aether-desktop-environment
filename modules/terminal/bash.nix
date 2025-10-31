{ config, aether, ... }:
{
	programs.bash = {
		interactiveShellInit = ''
			eval $(starship init bash)
		'';
	};
}
