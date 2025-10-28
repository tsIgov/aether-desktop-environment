{ aether, lib, ... }:
{
	environment.systemPackages = [
		aether.pkgs.aether-install
	];

	services = {
		getty = {
			autologinUser = lib.mkForce "root";
			greetingLine = "<<< Welcome to AetherOS >>>\n";
			helpLine = "";
		};
	};

	programs.bash.shellInit = ''aether-install'';
}
