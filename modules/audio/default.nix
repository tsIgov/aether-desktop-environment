{
	system = { pkgs, ... }:
	{
		environment.etc."aether/audio/scripts".source = ./scripts;

		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};

		environment.systemPackages = with pkgs; [
			pulseaudio # Sound server
			pulsemixer # TUI for pulseaudio
			ponymix # CLI for pulseaudio volume control
			playerctl # CLI for controlling media players
		];
	};
}
