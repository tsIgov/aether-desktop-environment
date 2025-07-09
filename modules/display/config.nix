{
	home = { pkgs, config, ... }:
	let
		cfg = config.aether.display.profiles;
		match-profile-script = builtins.readFile ./scripts/aether-display-match-profile.sh;
		auto-profile-script = builtins.readFile ./scripts/aether-display-auto-profile.sh;
	in
	{
		home.file.".config/aether/display-profiles.json".text = builtins.toJSON cfg;

		home.packages = [
			(pkgs.writeShellScriptBin "aether-display-match-profile" match-profile-script)
			(pkgs.writeShellScriptBin "aether-display-auto-profile" auto-profile-script)
		];

		wayland.windowManager.hyprland.settings.exec-once = [
			"aether-display-auto-profile"
		];
	};
}
