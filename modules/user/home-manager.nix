{ ... }:
	{
		programs.home-manager.enable = true;
		news.display = "silent";
		home = {
			username = builtins.getEnv "USER";
			homeDirectory = builtins.getEnv "HOME";
			stateVersion = "23.11";
		};
	}