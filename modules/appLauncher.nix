{
	home = { aether, config, pkgs, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		imports = [aether.inputs.anyrun.homeManagerModules.default];

		programs.anyrun = {
			enable = true;
			package = aether.inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
			config = {
				x = { fraction = 0.5; };
				y = { fraction = 0.5; };
				width = { absolute = 800; };
				height = { absolute = 240; };
				hideIcons = false;
				ignoreExclusiveZones = false;
				layer = "overlay";
				hidePluginInfo = false;
				closeOnClick = true;
				showResultsImmediately = true;
				maxEntries = 5;

				plugins = with aether.inputs.anyrun.packages.${pkgs.system}; [
					applications
					rink
					stdin
					dictionary
					websearch
					randr
				];
			};

			extraCss = ''
			#window {
				background-color: alpha(#${palette.base}, 0.3);
			}

			box#main {
				border-radius: 10px;
				background-color: #${palette.mantle};
				border: 1px solid #${palette.overlay0};
			}

			list#main {
				background-color: #${palette.mantle};
				border-radius: 10px;
			}

			label#match-desc {
				font-size: 0.8rem;
			}
			'';

			extraConfigFiles = {

				"dictionary.ron".text = ''
					Config(
						prefix: ":def",
						max_entries: 5,
					)
				'';

				"randr.ron".text = ''
					Config(
						prefix: ":dp",
						max_entries: 5,
					)
				'';

				"websearch.ron".text = ''
					Config(
						prefix: "?",
						engines: [Google, Custom(name: "Wikipedia", url: "en.wikipedia.org/wiki/{}",)]
					)
				'';

			};
		};
	};
}
