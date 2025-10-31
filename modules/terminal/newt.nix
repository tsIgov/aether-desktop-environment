{ config, ... }:
let
	palette = config.aether.theme.color-scheme;
in
{
	hm = {
		home.sessionVariables = {
			NEWT_COLORS=''
				root=#${palette.foreground0},#${palette.background0}
				border=#${palette.primary},#${palette.background0}
				window=#${palette.foreground0},#${palette.background0}
				shadow=#${palette.background0},#${palette.background0}
				title=#${palette.foreground0},#${palette.background0}
				button=#${palette.background0},#${palette.primary}
				actbutton=#${palette.background0},#${palette.primary}
				compactbutton=#${palette.foreground0},#${palette.background0}
				checkbox=#${palette.foreground0},#${palette.background0}
				actcheckbox=#${palette.primary},#${palette.background0}
				entry=#${palette.foreground0},#${palette.background0}
				disentry=#${palette.foreground1},#${palette.foreground0}
				label=#${palette.foreground1},#${palette.background0}
				listbox=#${palette.foreground0},#${palette.background0}
				actlistbox=#${palette.primary},#${palette.background0}
				sellistbox=#${palette.primary},#${palette.background0}
				actsellistbox=#${palette.primary},#${palette.background0}
				textbox=#${palette.background0},#${palette.foreground0}
				acttextbox=#${palette.background0},#${palette.primary}
				emptyscale=,#${palette.background0}
				fullscale=,#${palette.primary}
				helpline=#${palette.foreground1},#${palette.background0}
				roottext=#${palette.foreground0},#${palette.background0}
			'';

			# NEWT_MONO = 1;
		};
	};
}
