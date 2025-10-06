{ config, pkgs, lib, ... }:
{
	isoImage = {
		isoBaseName = lib.mkForce "aether-os-installer";
		appendToMenuLabel = "AetherOS Installer";
	};

 	# Packages needed inside the ISO
	environment.systemPackages = with pkgs; [
		nano
		dialog
		parted
		cryptsetup
		lvm2
		btrfs-progs
		networkmanager
		wpa_supplicant
		iw
		curl
		openssl
	];

	boot = {
		loader = {
			timeout = lib.mkForce 0;
			systemd-boot = {
				enable = true;
				editor = false;
			};

			efi.canTouchEfiVariables = true;
		};

		initrd.verbose = false;

		plymouth = {
			enable = true;
			theme =  "bgrt";
			logo = ../logos/logo-64x64.png;
		};
	};

	networking = {
		hostName = "aether-os";
		networkmanager.enable = true;
		wireless.enable = lib.mkForce false;
	};

	users = {
		users.aether = {
			description = "aether";
			extraGroups = [ "wheel" "networkmanager" ];
			password = "";
			isNormalUser = true;
			isSystemUser = false;
		};
	};

	services = {
		getty = {
			autologinUser = lib.mkForce "aether";
			greetingLine = "<<< Welcome to AetherOS >>>";
			helpLine = "";
		};
	};

	environment.etc."installer.sh" = {
		text = builtins.readFile ./installer.sh;
		mode = "0755";
	};

	programs.bash.shellInit = ''/etc/installer.sh'';
}
