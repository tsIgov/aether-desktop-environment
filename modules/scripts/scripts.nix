 { pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		jq
		(pkgs.writeShellScriptBin "aether" (builtins.readFile ./aether.sh))
		(pkgs.writeShellScriptBin "aether-system" (builtins.readFile ./aether-system.sh))
	];
}