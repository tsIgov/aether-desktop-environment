{ pkgs, config, aether, ... }:
let 
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	home.packages = with pkgs; [
		clipse
		wl-clipboard
		wl-clip-persist
	];

	wayland.windowManager.hyprland.settings.exec-once = [
		"${pkgs.clipse}/bin/clipse -listen"
		"${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular"
	];

	home.file = {
		".config/clipse/config.json".text = ''
			{
				"allowDuplicates": false,
				"historyFile": "clipboard_history.json",
				"maxHistory": 1000,
				"logFile": "clipse.log",
				"themeFile": "custom_theme.json",
				"tempDir": "tmp_files",
				"keyBindings": {
					"choose": "enter",
					"clearSelected": "S",
					"down": "down",
					"end": "end",
					"filter": "/",
					"home": "home",
					"more": "?",
					"nextPage": "right",
					"prevPage": "left",
					"preview": " ",
					"quit": "q",
					"remove": "x",
					"selectDown": "ctrl+down",
					"selectSingle": "s",
					"selectUp": "ctrl+up",
					"togglePin": "p",
					"togglePinned": "tab",
					"up": "up",
					"yankFilter": "ctrl+s"
				},
				"imageDisplay": {
					"type": "kitty",
					"scaleX": 9,
					"scaleY": 9,
					"heightCut": 2
				}
			}
		'';

		".config/clipse/custom_theme.json".text = ''
			{
				"useCustomTheme": true,
				"TitleFore": "#${palette.accent}",
				"TitleInfo": "#${palette.subtext0}",
				"NormalTitle": "#${palette.text}",
				"DimmedTitle": "#${palette.subtext0}",
				"SelectedTitle": "#${palette.accent}",
				"NormalDesc": "#${palette.surface2}",
				"DimmedDesc": "#${palette.surface2}",
				"SelectedDesc": "#${palette.surface2}",
				"StatusMsg": "#${palette.green}",
				"PinIndicatorColor": "#${palette.green}",
				"SelectedBorder": "#${palette.accent}",
				"SelectedDescBorder": "#${palette.accent}",
				"FilteredMatch": "#${palette.text}",
				"FilterPrompt": "#${palette.accent}",
				"FilterInfo": "#${palette.green}",
				"FilterText": "#${palette.text}",
				"FilterCursor": "#${palette.accent}",
				"HelpKey": "#${palette.accent}",
				"HelpDesc": "#${palette.subtext0}",
				"PageActiveDot": "#${palette.accent}",
				"PageInactiveDot": "#${palette.surface2}",
				"DividerDot": "#${palette.accent}",
				"PreviewedText": "#${palette.text}",
				"PreviewBorder": "#${palette.accent}"
			}
		'';
	};
}
