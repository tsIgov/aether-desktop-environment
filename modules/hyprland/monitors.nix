{
	home = { ... }:
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				exec-once = laptop-lid-action
				bindl = , switch:Lid Switch, exec, laptop-lid-action
			'';

			settings = {
				monitor = [
					",preferred,auto,auto"
				];
				source = [
					"~/.config/hypr/monitors.conf"
					"~/.config/hypr/workspaces.conf"
				];
			};
		};
	};
}
