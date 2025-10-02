{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		eog # imaget viewer
		celluloid # multimedia player
		evince # pdf viewer
	];
}
