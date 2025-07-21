{
	system = { lib, config, pkgs, ... }:
	let
		cfg = config.aether.storage.garbage-collection;
	in
	{
		config = lib.mkIf cfg.enable {
			systemd.services.garbage-collector = {
				description = "Nix Garbage Collector";
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
				serviceConfig.Type = "oneshot";
				startAt = cfg.schedule;
			};

			systemd.timers.garbage-collector = {
				timerConfig = {
					Persistent = true;
				};
			};
		};
	};
}
