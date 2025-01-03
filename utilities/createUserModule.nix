name: value: 
args: 
{ 
	config = {
		home = {
			username = name;
			homeDirectory = "/home/${name}";
			stateVersion = "24.05";
		};
	};
	imports = value; 
}