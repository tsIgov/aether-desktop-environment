{ lib, config, ... }:

{
	options.appearance.colors.roles = with lib; with types; with config.appearance.colors.palette; {
		primary = {
			default = mkOption { type = str; description = "High-emphasis fills, texts, and icons against surface"; default = primary.tone-80; };
			hovered = mkOption { type = str; description = "Hovered primary component"; default = primary.tone-70; };
			focused = mkOption { type = str; description = "Focused primary component"; default = primary.tone-60; };
			pressed = mkOption { type = str; description = "Pressed primary component"; default = primary.tone-60; };
			dragged = mkOption { type = str; description = "Dragged primary component"; default = primary.tone-60; };
			disabled = mkOption { type = str; description = "Disabled primary component "; default = primary.tone-40; };
			on = mkOption { type = str; description = "Text and icons against primary"; default = primary.tone-20; };
		};

		primary-container = {
			default = mkOption { type = str; description = "Standout fill color against surface, for key components like FAB"; default = primary.tone-30; };
			hovered = mkOption { type = str; description = "Hovered primary container component"; default = primary.tone-35; };
			focused = mkOption { type = str; description = "Focused primary container component"; default = primary.tone-40; };
			pressed = mkOption { type = str; description = "Pressed primary container component"; default = primary.tone-40; };
			dragged = mkOption { type = str; description = "Dragged primary container component"; default = primary.tone-40; };
			disabled = mkOption { type = str; description = "Disabled primary container component"; default = primary.tone-15; };
			on = mkOption { type = str; description = "Text and icons against primary container"; default = primary.tone-90; };
		};

		secondary = {
			default = mkOption { type = str; description = "Less prominent fills, text, and icons against surface"; default = secondary.tone-80; };
			hovered = mkOption { type = str; description = "Hovered secondary component"; default = secondary.tone-70; };
			focused = mkOption { type = str; description = "Focused secondary component"; default = secondary.tone-60; };
			pressed = mkOption { type = str; description = "Pressed secondary component"; default = secondary.tone-60; };
			dragged = mkOption { type = str; description = "Dragged secondary component"; default = secondary.tone-60; };
			disabled = mkOption { type = str; description = "Disabled secondary component"; default = secondary.tone-40; };
			on = mkOption { type = str; description = "Text and icons against secondary"; default = secondary.tone-20; };
		};

		secondary-container = {
			default = mkOption { type = str; description = "Less prominent fill color against surface, for recessive components like tonal buttons"; default = primary.tone-30; };
			hovered = mkOption { type = str; description = "Hovered secondary container component"; default = secondary.tone-35; };
			focused = mkOption { type = str; description = "Focused secondary container component"; default = secondary.tone-40; };
			pressed = mkOption { type = str; description = "Pressed secondary container component"; default = secondary.tone-40; };
			dragged = mkOption { type = str; description = "Dragged secondary container component"; default = secondary.tone-40; };
			disabled = mkOption { type = str; description = "Disabled secondary container component"; default = secondary.tone-15; };
			on = mkOption { type = str; description = "Text and icons against secondary container"; default = secondary.tone-90; };
		};

		tertiary = {
			default = mkOption { type = str; description = "Complementary fills, text, and icons against surface"; default = tertiary.tone-80; };
			hovered = mkOption { type = str; description = "Hovered tertiary component"; default = tertiary.tone-70; };
			focused = mkOption { type = str; description = "Focused tertiary component"; default = tertiary.tone-60; };
			pressed = mkOption { type = str; description = "Pressed tertiary component"; default = tertiary.tone-60; };
			dragged = mkOption { type = str; description = "Dragged tertiary component"; default = tertiary.tone-60; };
			disabled = mkOption { type = str; description = "Disabled tertiary component"; default = tertiary.tone-40; };
			on = mkOption { type = str; description = "Text and icons against tertiary"; default = tertiary.tone-20; };
		};

		tertiary-container = {
			default = mkOption { type = str; description = "Complementary container color against surface, for components like input fields"; default = tertiary.tone-30; };
			hovered = mkOption { type = str; description = "Hovered tertiary container component"; default = tertiary.tone-35; };
			focused = mkOption { type = str; description = "Focused tertiary container component"; default = tertiary.tone-40; };
			pressed = mkOption { type = str; description = "Pressed tertiary container component"; default = tertiary.tone-40; };
			dragged = mkOption { type = str; description = "Dragged tertiary container component"; default = tertiary.tone-40; };
			disabled = mkOption { type = str; description = "Disabled tertiary container component"; default = tertiary.tone-15; };
			on = mkOption { type = str; description = "Text and icons against tertiary container"; default = tertiary.tone-90; };
		};

		error = {
			default = mkOption { type = str; description = "Attention-grabbing color against surface for fills, icons, and text, indicating urgency"; default = error.tone-80; };
			hovered = mkOption { type = str; description = "Hovered error component"; default = error.tone-70; };
			focused = mkOption { type = str; description = "Focused error component"; default = error.tone-60; };
			pressed = mkOption { type = str; description = "Pressed error component"; default = error.tone-60; };
			dragged = mkOption { type = str; description = "Dragged error component"; default = error.tone-60; };
			disabled = mkOption { type = str; description = "Disabled error component"; default = error.tone-40; };
			on = mkOption { type = str; description = "Text and icons against error"; default = error.tone-20; };
		};

		error-container = {
			default = mkOption { type = str; description = "Attention-grabbing fill color against surface"; default = error.tone-30; };
			hovered = mkOption { type = str; description = "Hovered error container component"; default = error.tone-35; };
			focused = mkOption { type = str; description = "Focused error container component"; default = error.tone-40; };
			pressed = mkOption { type = str; description = "Pressed error container component"; default = error.tone-40; };
			dragged = mkOption { type = str; description = "Dragged error container component"; default = error.tone-40; };
			disabled = mkOption { type = str; description = "Disabled error container component"; default = error.tone-15; };
			on = mkOption { type = str; description = "Text and icons against error container"; default = error.tone-90; };
		};

		surface = {
			default = mkOption { type = str; description = "Default color for backgrounds"; default = neutral.tone-05; };
			variant = mkOption { type = str; description = "Alternate surface color, can be used for active states"; default = neutral-variant.tone-30; };
			on = mkOption { type = str; description = "Text and icons against any surface color"; default = neutral.tone-90; };
			on-variant = mkOption { type = str; description = "Lower-emphasis color for text and icons against any surface color"; default = neutral-variant.tone-80; };
		};

		surface-container = {
			lowest = mkOption { type = str; description = "Lowest-emphasis container color"; default = neutral.tone-05; };
			low = mkOption { type = str; description = "Low-emphasis container color"; default = neutral.tone-10; };
			default = mkOption { type = str; description = "Default container color"; default = neutral.tone-15; };
			high = mkOption { type = str; description = "High-emphasis container color"; default = neutral.tone-20; };
			highest = mkOption { type = str; description = "Highest-emphasis container color"; default = neutral.tone-25; };
		};

		inverse-surface = {
			default = mkOption { type = str; description = "Background fills for elements which contrast against surface"; default = neutral.tone-90; };
			on = mkOption { type = str; description = "Text and icons against inverse surface"; default = neutral.tone-20; };
			primary = mkOption { type = str; description = "Actionable elements, such as text buttons, against inverse surface"; default = primary.tone-80; };
		};

		outline = {
			default = mkOption { type = str; description = "Important boundaries, such as a text field outline"; default = neutral-variant.tone-60; };
			variant = mkOption { type = str; description = "Decorative elements, such as dividers"; default = neutral-variant.tone-30; };
		};

		shadow = mkOption { type = str; description = "For shadows applied to elevated components"; default = neutral.tone-05; };
		skrim = mkOption { type = str; description = "Used for scrims which help separate floating components from the background"; default = neutral.tone-05; };

		ansi = {
			regular = {
				black = mkOption { type = str; };
				red = mkOption { type = str; };
				green = mkOption { type = str; };
				yellow = mkOption { type = str; };
				blue = mkOption { type = str; };
				magenta = mkOption { type = str; };
				cyan = mkOption { type = str; };
				white = mkOption { type = str; };
			};
			bright = {
				black = mkOption { type = str; };
				red = mkOption { type = str; };
				green = mkOption { type = str; };
				yellow = mkOption { type = str; };
				blue = mkOption { type = str; };
				magenta = mkOption { type = str; };
				cyan = mkOption { type = str; };
				white = mkOption { type = str; };
			};
		};
	};
}