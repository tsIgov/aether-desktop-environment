{
	system = { pkgs, ... }:
	{
		environment.systemPackages = with pkgs; [
			hyprlock
		];

		security.pam.services.hyprlock = {};
	};

	home = { aether, config, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
		font = config.aether.appearance.fonts.regular;

		wallpapersPkg = (aether.pkgs.wallpapers.override {
				flavor = config.aether.appearance.colors.flavor;
				accent = config.aether.appearance.colors.primary;
		});
		wallpaper = "${wallpapersPkg}/${config.aether.appearance.wallpaper}.png";
	in
	{
		programs.hyprlock = {
			enable = true;
			settings = {
				general = {
					ignore_empty_input = true;
					hide_cursor = true;
					immediate_render = true;
				};

				background = [
					{
						path = wallpaper;
						color = "rgb(${palette.base})";
					}
				];

				shape = [
					{
						size = "100%, 100%";
						color = "rgba(00000090)";
						rounding = 0;
						border_size = 0;
						position = "0, 0";
						halign = "left";
						valign = "top";
					}
				];

				label = [
					{
						text = "$LAYOUT";
						color = "rgb(${palette.text})";
						font_size = 12;
						font_family = "${font}";
						position = "-10, -10";
						halign = "right";
						valign = "top";
					}

					{
						text = "cmd[update:1000] [ \"$(echo $(swaync-client -c))\" -eq 0 ] && echo \"\" || echo \"\"";
						color = "rgb(${palette.primary})";
						font_size = 40;
						font_family = "${config.aether.appearance.fonts.icons}";
						position = "0, -40";
						halign = "center";
						valign = "top";

						shadow_passes = 3;
						shadow_size = 3;
						shadow_color = "rgb(0,0,0)";
						shadow_boost = 1.2;
					}


					{
						text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
						color = "rgb(${palette.text})";
						font_size = 20;
						font_family = "${font}";
						position = "0, 75";
						halign = "center";
						valign = "center";

						shadow_passes = 3;
						shadow_size = 3;
						shadow_color = "rgb(0,0,0)";
						shadow_boost = 1.2;
					}

					{
						text = "$TIME";
						color = "rgb(${palette.text})";
						font_size = 90;
						font_family = "${font}";
						position = "0, 0";
						halign = "center";
						valign = "center";

						shadow_passes = 3;
						shadow_size = 3;
						shadow_color = "rgb(0,0,0)";
						shadow_boost = 1.2;
					}
				];

				input-field = [
					{
						size = "300, 50";
						position = "0, -90";
						halign = "center";
						valign = "center";

						outline_thickness = 0;

						dots_size = 0.30;
						dots_spacing = 0.55;
						dots_center = true;
						dots_rounding = -1;

						outer_color = "rgba(00000000)";
						inner_color = "rgba(00000000)";
						font_color = "rgb(${palette.text})";
						font_family = "${font}";

						fade_on_empty = false;
						placeholder_text = "";
						hide_input = false;

						check_color = "rgb(${palette.primary})";
						fail_color = "rgb(${palette.error})";
						fail_text = "Invalid credentials";
						fail_timeout = 3000;
						fail_transition = 300;

						capslock_color = "rgb(${palette.yellow})";
						numlock_color = -1;
						bothlock_color = "rgb(${palette.yellow})";
						invert_numlock = true;

						swap_font_color = true;

						shadow_passes = 3;
						shadow_size = 3;
						shadow_color = "rgb(0,0,0)";
						shadow_boost = 1.2;
					}
				];
			};
		};

		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = SUPER, L, exec, pidof hyprlock || hyprlock
			'';
		};
	};

}
