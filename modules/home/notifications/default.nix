{ config, ... }:

{
	services.mako = {
		enable = true;
		anchor = "top-center";
		backgroundColor = "#${config.appearance.colors.roles.surface-container.default}";
		borderColor = "#${config.appearance.colors.roles.primary.default}";
		borderRadius = 5;
		borderSize = 1;
		defaultTimeout = 10000;
		font = "monospace 10";
		height = 100;
		ignoreTimeout = true; # Ignores the timeout sent by notifications and uses the default timeout instead.
		layer = "overlay";
		margin = "10";
		maxVisible = -1;
		padding = "5";
		progressColor ="over #5588AAFF";
		textColor = "#FFFFFF";
		extraConfig = ''
[urgency=low]
border-color=#b8bb26ff

[urgency=high]
border-color=#ff0000ff'';
		
	};
}