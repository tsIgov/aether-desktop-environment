{ pkgs, config, lib, ... }:
let
	cfg = config.aether.display.profiles;

	applyScript = pkgs.writeShellApplication {
		name = "refresh-display-profile";
		runtimeInputs = [ pkgs.hyprland pkgs.jq ];
		text = builtins.readFile ./scripts/apply-profile.sh;
	};
in
{
	environment.etc."aether/display/scripts".source = ./scripts;

	environment.systemPackages = with pkgs; [
		wdisplays # monitor layout tool
		brightnessctl # controls display brightness
	];

	hm = {
		wayland.windowManager.hyprland.settings = {
			source = [
				"~/.config/hypr/monitors.conf"
			];

			exec-once = [
				"sh /etc/aether/display/scripts/auto-profile.sh"
			];
		};

		home.file.".config/aether/display/profiles.json".text = builtins.toJSON cfg;

		home.packages = [
			applyScript
		];

		# home.activation = {
		# 	resetDisplay = lib.hm.dag.entryAfter ["writeBoundary"] ''
		# 		${applyScript}/bin/refresh-display-profile
		# 	'';
		# };

		systemd.user.services.aether-fallback-display-profile = {
			Unit = {
				Description = "Resets monitor configuration if no enabled monitors are found";
				After = [ "hyprland-session.target" ];
			};
			Service = {
				Type = "oneshot";
				ExecStart = "/bin/sh -c '/etc/aether/display/scripts/fallback-reset.sh'";
				Restart = "no";
			};
			Install = {
				WantedBy = [ "default.target" ];
			};
		};
	};
}
