{
	home = { pkgs, config, ... }:
	{
		home.file.".config/walker/config.json".text = ''
{
	"activation_mode": {
		"disabled": true
	},
	"app_launch_prefix": "",
	"as_window": false,
	"builtins": {
		"applications": {
			"hidden": true,
			"switcher_only": false,
			"context_aware": true,
			"prioritize_new": false,
			"show_generic": true,
			"actions": {
				"enabled": false
			}
		},
		"ai": {
			"hidden": true,
			"switcher_only": true
		},
		"bookmarks": {
			"hidden": true,
			"switcher_only": true
		},
		"calc": {
			"hidden": false,
			"switcher_only": false
		},
		"clipboard": {
			"hidden": true,
			"switcher_only": true
		},
		"commands": {
			"hidden": true,
			"switcher_only": true
		},
		"custom_commands": {
			"hidden": true,
			"switcher_only": true
		},
		"dmenu": {
			"hidden": true,
			"switcher_only": true
		},
		"emojis": {
			"hidden": false,
			"switcher_only": true
		},
		"finder": {
			"hidden": true,
			"switcher_only": true
		},
		"runner": {
			"hidden": true,
			"switcher_only": true
		},
		"ssh": {
			"hidden": true,
			"switcher_only": true
		},
		"switcher": {
			"hidden": false,
			"switcher_only": true
		},
		"symbols": {
			"hidden": true,
			"switcher_only": true
		},
		"translation": {
			"hidden": false,
			"switcher_only": true,
			"provider": "googlefree"
		},
		"websearch": {
			"hidden": true,
			"switcher_only": true
		},
		"windows": {
			"hidden": true,
			"switcher_only": true
		}
	},
	"close_when_open": true,
	"disabled": [ "clipboard" ],
	"disable_click_to_close": false,
	"keys": {
		"accept_typeahead": "tab",
		"trigger_labels": "lalt",
		"next": "down",
		"prev": "up",
		"close": "esc",
		"remove_from_history": "shift backspace",
		"resume_query": "ctrl r",
		"toggle_exact_search": "ctrl m"
	},
	"force_keyboard_focus": true,
	"hotreload_theme": false,
	"ignore_mouse": true,
	"list": {
		"cycle": true,
		"dynamic_sub": false,
		"keyboard_scroll_style": "emacs",
		"max_entries": 10,
		"placeholder": "No Results",
		"show_initial_entries": true,
		"single_click": true,
		"visibility_threshold": 20
	},
	"plugins": [
		{
			"keep_sort":  true,
			"name": "power",
			"placeholder":  "Power",
			"recalculate_score":  true,
			"show_icon_when_single":  true,
			"switcher_only":  false,
			"entries": [
				{
					"exec": "systemctl shutdown",
					"icon": "system-shutdown",
					"label": "Shutdown"
				},
				{
					"exec": "systemctl reboot",
					"icon": "system-reboot",
					"label": "Reboot"
				},
				{
					"exec": "hyprctl dispatch exit",
					"icon": "system-log-out",
					"label": "Logout"
				},
				{
					"exec": "systemctl suspend",
					"icon": "system-suspend",
					"label": "Suspend"
				},
				{
					"exec": "systemctl hibernate",
					"icon": "system-hibernate",
					"label": "Hibernate"
				}
			]
		},
		{
			"keep_sort":  true,
			"name": "screenshot",
			"placeholder":  "Screenshot",
			"recalculate_score":  true,
			"show_icon_when_single":  true,
			"switcher_only":  false,
			"entries": [
			]
		}
	],
	"search": {
		"argument_delimiter": "#",
		"placeholder": "Search...",
		"delay": 0,
		"resume_last_query": false
	},
	"terminal": "kitty",
	"terminal_title_flag": "--title",
	"theme": "aether",
	"timeout": 0
}
			'';
	};
}
