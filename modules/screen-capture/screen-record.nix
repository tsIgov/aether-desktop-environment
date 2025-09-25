{ pkgs, lib, aether, ... }:
{
	environment.systemPackages = with pkgs; [
		kooha
	];

	hm = {
		dconf.settings = {
			"io/github/seadve/Kooha" = {
				capture-mode = "monitor-window";
				record-delay = lib.gvariant.mkUint32(3);
			};
		};

		home.activation = {
			set-recording-dir = aether.inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
				mkdir -p "$HOME/Videos/Recordings" && echo -e "[/]\nsaving-location=b'$HOME/Videos/Recordings'" | ${pkgs.dconf}/bin/dconf load /io/github/seadve/Kooha/
			'';
		};
	};
}
