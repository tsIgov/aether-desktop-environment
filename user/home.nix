name:  
{ ... }: 
{ 
	programs.home-manager.enable = true;
	news.display = "silent";

	home = {
		username = name;
		homeDirectory = "/home/${name}";
		stateVersion = "24.05";
	};
}