{
	system = { pkgs, ... }:
	let
		script = builtins.readFile ./scripts/auto-profile.sh;
	in
	{
		environment.etc."aether/display/scripts".source = ./scripts;

		environment.systemPackages = with pkgs; [
			wdisplays # monitor layout tool
			brightnessctl # controls display brightness
			(pkgs.writeShellScriptBin "aether-display-auto-profile" script)
		];
	};

	home = { pkgs, config, ... }:
	let
		cfg = config.aether.display.profiles;
	in
	{
		home.file.".config/aether/display/profiles.json".text = builtins.toJSON cfg;

		wayland.windowManager.hyprland.settings = {
			source = [
				"~/.config/hypr/monitors.conf"
			];

			exec-once = [
				"aether-display-auto-profile"
			];
		};
	};
}
