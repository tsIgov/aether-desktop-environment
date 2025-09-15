{ pkgs, ... }:
{
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	environment.systemPackages = with pkgs; [
		pulseaudio # Sound server
		ponymix # CLI for pulseaudio volume control
		playerctl # CLI for controlling media players
		wiremix # TUI for controlling audio
	];

	hm = {
		wayland.windowManager.hyprland = {
			settings = {
				windowrulev2 = [
					"float, class:(wiremix)"
					"center 1, class:(wiremix)"
					"size 700 500, class:(wiremix)"
				];
			};
		};
	};
}
