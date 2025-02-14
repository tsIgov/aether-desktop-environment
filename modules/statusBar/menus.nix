{
	home = { ... }:
	{
		programs.hyprpanel = {
			settings = {

				menus = {
					transition = "crossfade";
					transitionTime = 0;
				};

				theme.bar.menus = {
					buttons.radius = "0.2rem";
					card_radius = "0.2rem";
					monochrome = true;
					opacity = 100;

					border = {
						radius = "0.2rem";
						size = "0.1rem";
					};

					popover = {
						radius = "0.2rem";
						scaling = 80;
					};

					progressbar.radius = "1rem";

					scroller = {
						radius = "0.2rem";
						width = "0.25em";
					};

					slider = {
						progress_radius = "1rem";
						slider_radius = "10rem";
					};

					switch = {
						radius = "10em";
						slider_radius = "10em";
					};

					tooltip.radius = "0.2rem";
				};
			};
		};
	};
}
