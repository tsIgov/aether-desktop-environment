{ config, lib, ... }:
let
	inherit (lib) mkOption;
	inherit (lib.types) str;

	cfg = config.aether.theme.color-scheme;
in
{
	options = {
		aether.theme.color-scheme = {
			foreground0 = mkOption { type = str; description="Text and foreground elements"; };
			foreground1 = mkOption { type = str; description="Subtext and dim foreground elements"; };
			foreground2 = mkOption { type = str; description="Faint foreground elements"; };

			overlay = mkOption { type = str; description="Lightbox and selection overlay"; };

			surface0 = mkOption { type = str; description="Surface elements background"; };
			surface1 = mkOption { type = str; description="Elevated surface elements background"; };
			surface2 = mkOption { type = str; description="Highlighted surface elements background"; };

			background0 = mkOption { type = str; description="Background pane"; };
			background1 = mkOption { type = str; description="Secondary pane"; };
			background2 = mkOption { type = str; description="Tertiary pane"; };

			red = mkOption { type = str; };
			blue = mkOption { type = str; };
			green = mkOption { type = str; };
			cyan = mkOption { type = str; };
			yellow = mkOption { type = str; };
			magenta = mkOption { type = str; };
			orange = mkOption { type = str; };
			violet = mkOption { type = str; };

			primary = mkOption { type = str; description="Accent color"; };
			secondary = mkOption { type = str; description="Secondary accent color"; };
			warning = mkOption { type = str; description="Semantic color used for warnings"; };
			error = mkOption { type = str; description="Semantic color used for error or other critical messages"; };
		};

		aether.theme.gtk-color-scheme = mkOption { type = str; readOnly = true; };
	};

	config = {
		aether.theme = {
			gtk-color-scheme = ''
				@define-color background0 #${cfg.background0};
				@define-color background1 #${cfg.background1};
				@define-color background2 #${cfg.background2};

				@define-color foreground0 #${cfg.foreground0};
				@define-color foreground1 #${cfg.foreground1};
				@define-color foreground2 #${cfg.foreground2};

				@define-color surface0 #${cfg.surface0};
				@define-color surface1 #${cfg.surface1};
				@define-color surface2 #${cfg.surface2};

				@define-color overlay #${cfg.overlay};

				@define-color primary #${cfg.primary};
				@define-color secondary #${cfg.secondary};
				@define-color warning #${cfg.warning};
				@define-color error #${cfg.error};

				@define-color red #${cfg.red};
				@define-color blue #${cfg.blue};
				@define-color green #${cfg.green};
				@define-color cyan #${cfg.cyan};
				@define-color yellow #${cfg.yellow};
				@define-color magenta #${cfg.magenta};
				@define-color orange #${cfg.orange};
				@define-color violet #${cfg.violet};
			'';
		};
	};
}
