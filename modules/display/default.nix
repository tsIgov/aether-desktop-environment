{
	system = { pkgs, ... }:
	let
		script = builtins.readFile ./scripts/auto-profile.sh;
		applyScript = builtins.readFile ./scripts/apply-profile.sh;
	in
	{
		environment.etc."aether/display/scripts".source = ./scripts;

		environment.systemPackages = with pkgs; [
			wdisplays # monitor layout tool
			brightnessctl # controls display brightness
			(pkgs.writeShellScriptBin "aether-display-auto-profile" script)
		];
	};

	home = { pkgs, config, lib, ... }:
	let
		cfg = config.aether.display.profiles;

		applyScript = pkgs.writeShellApplication {
			name = "aether-display-apply-profile";
			runtimeInputs = [ pkgs.hyprland pkgs.jq ];
			text = builtins.readFile ./scripts/apply-profile.sh;
		};
	in
	{
		home.file.".config/aether/display/profiles.json".text = builtins.toJSON cfg;

		home.packages = [
			applyScript
		];

		home.activation = {
			resetDisplay = lib.hm.dag.entryAfter ["writeBoundary"] ''
				${applyScript}/bin/aether-display-apply-profile
			'';
		};

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
