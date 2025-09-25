{ pkgs, config, lib, ... }:
let
	cfg = config.aether.display.profiles;
in
{
	options.aether.display =  {
		profiles = mkOption {
			default = [];
			description = "When connecting or disconnecting monitors, the system will try to match a profile and set the monitors accordingly. For a profile to be matched all of its monitors must match an phisical and there should be not physical monitors unmatched.";
			type = listOf (submodule {
				options = {
					monitors = mkOption {
						type = listOf (submodule {
							options = {
								enabled = mkOption { type = bool; default = true; description = "Whether or not the monitor should be enabled when this profile is active."; };
								name = mkOption { type = str; description = "A regex to match the name of the monitor."; example = "DP-[1-9]"; };
								resolution = mkOption { type = str; default = "preferred"; description = "The resolution of the monitor in Hyprland format. See https://wiki.hypr.land/Configuring/Monitors/"; example = "1920x1080@144"; };
								position = mkOption { type = str; default = "auto"; description = "The position of the monitor in Hyprland format. See https://wiki.hypr.land/Configuring/Monitors/"; example = "1920x0"; };
								scale = mkOption { type = str; default = "auto"; description = "The scale of the monitor in Hyprland format. See https://wiki.hypr.land/Configuring/Monitors/"; example = "1"; };
								extraArgs = mkOption { type = str; default = ""; description = "Unformatted arguments that will be added at the end of the monitor rule. See https://wiki.hypr.land/Configuring/Monitors/"; example = "mirror, DP-2"; };
							};
						});
					};
				};
			});
		};
	};

	config = {
		environment.etc = {
			"aether/display/scripts/auto-profile.sh" = {
				source = pkgs.replaceVars ./scripts/auto-profile.sh {
					bash = "${pkgs.bash}/bin/bash";
				};
				mode = "0555";
			};
			"aether/display/scripts/apply-profile.sh" = {
				source = pkgs.replaceVars ./scripts/apply-profile.sh {
					bash = "${pkgs.bash}/bin/bash";
					hyprctl = "${pkgs.hyprland}/bin/hyprctl";
					jq = "${pkgs.jq}/bin/jq";
				};
				mode = "0555";
			};
			"aether/display/scripts/fallback-reset.sh" = {
				source = pkgs.replaceVars ./scripts/fallback-reset.sh {
					bash = "${pkgs.bash}/bin/bash";
					hyprctl = "${pkgs.hyprland}/bin/hyprctl";
					jq = "${pkgs.jq}/bin/jq";
				};
				mode = "0555";
			};
		};

		environment.etc."aether/display/monitor-profiles.json".text = builtins.toJSON cfg;


		environment.systemPackages = with pkgs; [
			wdisplays # monitor layout tool
			brightnessctl # controls display brightness
		];

		system.userActivationScripts = {
			resetDisplay = {
				text = ''/etc/aether/display/scripts/apply-profile.sh'';
				deps = [];
			};
		};

		hm = {
			wayland.windowManager.hyprland.settings = {
				source = [
					"~/.config/hypr/monitors.conf"
				];

				exec-once = [
					"sh /etc/aether/display/scripts/auto-profile.sh"
				];
			};

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
	};
}
