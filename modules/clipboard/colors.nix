{
	home = { pkgs, config, aether, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		home.file = {
			".config/clipse/custom_theme.json".text = ''
				{
					"useCustomTheme": true,
					"TitleFore": "#${palette.primary}",
					"TitleInfo": "#${palette.subtext0}",
					"NormalTitle": "#${palette.text}",
					"DimmedTitle": "#${palette.subtext0}",
					"SelectedTitle": "#${palette.primary}",
					"NormalDesc": "#${palette.surface2}",
					"DimmedDesc": "#${palette.surface2}",
					"SelectedDesc": "#${palette.surface2}",
					"StatusMsg": "#${palette.secondary}",
					"PinIndicatorColor": "#${palette.secondary}",
					"SelectedBorder": "#${palette.primary}",
					"SelectedDescBorder": "#${palette.primary}",
					"FilteredMatch": "#${palette.text}",
					"FilterPrompt": "#${palette.primary}",
					"FilterInfo": "#${palette.secondary}",
					"FilterText": "#${palette.text}",
					"FilterCursor": "#${palette.primary}",
					"HelpKey": "#${palette.primary}",
					"HelpDesc": "#${palette.subtext0}",
					"PageActiveDot": "#${palette.primary}",
					"PageInactiveDot": "#${palette.surface2}",
					"DividerDot": "#${palette.primary}",
					"PreviewedText": "#${palette.text}",
					"PreviewBorder": "#${palette.primary}"
				}
			'';
		};
	};
}
