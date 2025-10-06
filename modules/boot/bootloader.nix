{ pkgs, ... }:
{
	boot.loader = {
		timeout = 0;
		systemd-boot = {
			enable = true;
			editor = false;
			#configurationLimit = 10;
			extraInstallCommands = ''
				for f in /boot/loader/entries/nixos-generation-*.conf; do
					generation_id=$(${pkgs.coreutils}/bin/echo $f | ${pkgs.gnugrep}/bin/grep -o '[0-9]\+')
					${pkgs.gnused}/bin/sed -i 's/^title NixOS/title AetherOS/' "$f"
					${pkgs.gnused}/bin/sed -i "s/^version .*/version Generation $generation_id (built on $(${pkgs.coreutils}/bin/date +%F))/" "$f"
				done

			'';
		};

		efi.canTouchEfiVariables = true;
	};
}
