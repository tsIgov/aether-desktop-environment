{ aether, config, ... }:
let
	gtkPalette = aether.lib.appearance.getGtkColorDefinitions { inherit config; };
in
{
	nix.settings = {
		substituters = ["https://walker-git.cachix.org"];
		trusted-public-keys = ["walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="];
	};

	hm = {
		programs.walker = {
  			enable = true;
			runAsService = true;

			config = {
				close_when_open = true;
				disable_mouse = false;
				exact_search_prefix = "'";
				force_keyboard_focus = false;
				global_argument_delimiter = "#";
				keep_open_modifier = "shift";
				selection_wrap = false;
				theme = "aether";



				shell = {
					anchor_bottom = true;
					anchor_left = true;
					anchor_right = true;
					anchor_top = true;
				};

				keybinds = {
					close = "Escape";
					next = "Down";
					previous = "Up";
					quick_activate = ["F1" "F2" "F3"];
				};

				placeholders.default = {
					input = "Search";
					list = "No Results";
				};


				providers = {
					default = [ "desktopapplications" "providerlist" ];
					empty = [ "desktopapplications" ];
					prefixes = [
						{ provider = "websearch"; prefix = "+"; }
						{ provider = "providerlist"; prefix = "_"; }
					];
				};
			};
		};


		home.file.".config/walker/themes/aether/style.css".source = ./style.css;
		home.file.".config/walker/themes/aether/colors.css".text = gtkPalette;

		imports = [ aether.inputs.walker.homeManagerModules.default ];
	};
}
