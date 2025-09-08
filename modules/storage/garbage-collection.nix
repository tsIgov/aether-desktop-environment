{ lib, config, pkgs, ... }:
let
	cfg = config.aether.storage.garbage-collection;

	script = ''
		for USER_HOME in /home/*; do
			if [ -d "$USER_HOME" ]; then
				USERNAME=$(basename "$USER_HOME")
				${config.security.sudo.package}/bin/sudo -u "$USERNAME" ${pkgs.home-manager}/bin/home-manager expire-generations "-${toString cfg.daysOld} days"
			fi
		done

		${config.nix.package.out}/bin/nix-collect-garbage --delete-older-than ${toString cfg.daysOld}d
		${config.nix.package.out}/bin/nix-store --optimise
	'';
in
{
	config = lib.mkIf cfg.enable {

		environment.etc."aether/storage/scripts/gc.sh".text = ''
			#!/bin/sh

			${script}
		'';

		systemd.services.garbage-collector = {
			description = "Nix Garbage Collector";
			script = script;
			serviceConfig.Type = "oneshot";
			startAt = cfg.schedule;
		};

		systemd.timers.garbage-collector = {
			timerConfig = {
				Persistent = true;
			};
		};
	};
}
