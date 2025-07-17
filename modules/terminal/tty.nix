{
	system = { pkgs, config, aether, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		console = {
			font = "ter-124b";
			packages = with pkgs; [
				terminus_font
			];
			colors = with palette; [
				base red green yellow blue mauve sky subtext0
				surface0 maroon teal peach lavender pink sapphire subtext1
			];
		};
	};
}
