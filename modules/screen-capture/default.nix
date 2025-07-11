{
	system = { pkgs, ... }:
	let
		script = builtins.readFile ./scripts/aether-screen-capture-menu.sh;
	in
	{
		environment.systemPackages = with pkgs; [
			hyprshot
			(writeShellScriptBin "aether-screen-capture-menu" script)
		];
	};

	home = { pkgs, ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = , PRINT, exec, aether-screen-capture-menu
			'';
		};
	};
}
