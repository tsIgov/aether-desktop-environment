 { pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		pciutils
		jq

		(pkgs.writeShellScriptBin "aether" (builtins.readFile ./aether.sh))
		(pkgs.writeShellScriptBin "aether-system" (builtins.readFile ./aether-system.sh))
	];
}