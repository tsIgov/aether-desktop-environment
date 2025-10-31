{ pkgs, config, ... }:
let
	palette = config.aether.theme.color-scheme;
in
{
	hm = {
		home.file = {
			".config/clipse/custom_theme.json".text = ''
				{
					"useCustomTheme": true,
					"TitleFore": "#${palette.primary}",
					"TitleInfo": "#${palette.foreground1}",
					"NormalTitle": "#${palette.foreground0}",
					"DimmedTitle": "#${palette.foreground1}",
					"SelectedTitle": "#${palette.primary}",
					"NormalDesc": "#${palette.surface0}",
					"DimmedDesc": "#${palette.surface0}",
					"SelectedDesc": "#${palette.surface0}",
					"StatusMsg": "#${palette.secondary}",
					"PinIndicatorColor": "#${palette.secondary}",
					"SelectedBorder": "#${palette.primary}",
					"SelectedDescBorder": "#${palette.primary}",
					"FilteredMatch": "#${palette.foreground0}",
					"FilterPrompt": "#${palette.primary}",
					"FilterInfo": "#${palette.secondary}",
					"FilterText": "#${palette.foreground0}",
					"FilterCursor": "#${palette.primary}",
					"HelpKey": "#${palette.primary}",
					"HelpDesc": "#${palette.foreground1}",
					"PageActiveDot": "#${palette.primary}",
					"PageInactiveDot": "#${palette.surface0}",
					"DividerDot": "#${palette.primary}",
					"PreviewedText": "#${palette.foreground0}",
					"PreviewBorder": "#${palette.primary}"
				}
			'';
		};
	};
}
