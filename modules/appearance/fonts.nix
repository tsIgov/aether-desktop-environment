{ pkgs, config, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str ints;

	cfg = config.aether.appearance.fonts;
in
{
	options.aether.appearance = {
		fonts = {
			size = mkOption { type = ints.positive; default = 11; };
			regular = mkOption { type = str; default = "Inter"; };
			mono = mkOption { type = str; default = "Hack Nerd Font Mono"; };
			emoji = mkOption { type = str; default = "Noto Emoji"; };
			icons = mkOption { type = str; default = "Hack Nerd Font Propo"; };
		};
	};

	config = {
		fonts = {
			packages = with pkgs; [
				inter
				nerd-fonts.hack
				noto-fonts-monochrome-emoji
			];
			fontconfig = {
				enable = true;
				defaultFonts = {
					serif = [ cfg.regular ];
					sansSerif = [ cfg.regular ];
					monospace = [ cfg.mono ];
					emoji = [ cfg.emoji ];
				};
			};
		};

		hm = {
			fonts.fontconfig = {
				enable = true;
				defaultFonts = {
					serif = [ cfg.regular ];
					sansSerif = [ cfg.regular ];
					monospace = [ cfg.mono ];
					emoji = [ cfg.emoji ];
				};
			};

			gtk = {
				font = {
					name = cfg.mono;
					size = cfg.size;
				};
			};
		};
	};
}

