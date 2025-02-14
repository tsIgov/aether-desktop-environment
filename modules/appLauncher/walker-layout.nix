{
	home = { pkgs, config, aether, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		home.file.".config/walker/themes/aether.json".text = ''
{
	"ui": {
		"anchors": {
			"bottom": false,
			"left": true,
			"right": true,
			"top": true
		},
		"window": {
			"h_align": "fill",
			"v_align": "fill",
			"box": {
				"h_align": "center",
				"width": 450,
				"margins": {
					"top": 59
				},
				"bar": {
					"orientation": "horizontal",
					"position": "end",
					"entry": {
						"h_align": "fill",
						"h_expand": true,
						"icon": {
							"h_align": "center",
							"h_expand": true,
							"pixel_size": 24
						}
					}
				},
				"scroll": {
					"list": {
						"marker_color": "#${palette.accent}",
						"max_height": 300,
						"max_width": 400,
						"min_width": 400,
						"width": 400,
						"margins": {
							"top": 8
						},
						"item": {
							"icon": {
								"pixel_size": 26
							}
						}
					}
				},
				"search": {
					"prompt": {
						"name": "prompt",
						"icon": "edit-find",
						"pixel_size": 18,
						"h_align": "center",
						"v_align": "center"
					},
					"clear": {
						"name": "clear",
						"icon": "edit-clear",
						"pixel_size": 18,
						"h_align": "center",
						"v_align": "center"
					},
					"input": {
						"h_align": "fill",
						"h_expand": true,
						"icons": true
					},
					"spinner": {
						"hide": true
					}
				}
			}
		}
	}
}
		'';
	};
}
