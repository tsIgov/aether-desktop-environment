{ config, aether, ... }:
let
	palette = aether.lib.appearance.getPalette { inherit config; };
in
{
	hm = {
		home.sessionVariables = {
			NEWT_COLORS=''
				root=#${palette.text},#${palette.base}
				border=#${palette.primary},#${palette.base}
				window=#${palette.text},#${palette.base}
				shadow=#${palette.base},#${palette.base}
				title=#${palette.text},#${palette.base}
				button=#${palette.base},#${palette.primary}
				actbutton=#${palette.base},#${palette.primary}
				compactbutton=#${palette.text},#${palette.base}
				checkbox=#${palette.text},#${palette.base}
				actcheckbox=#${palette.primary},#${palette.base}
				entry=#${palette.text},#${palette.base}
				disentry=#${palette.subtext0},#${palette.text}
				label=#${palette.subtext0},#${palette.base}
				listbox=#${palette.text},#${palette.base}
				actlistbox=#${palette.primary},#${palette.base}
				sellistbox=#${palette.primary},#${palette.base}
				actsellistbox=#${palette.primary},#${palette.base}
				textbox=#${palette.base},#${palette.text}
				acttextbox=#${palette.base},#${palette.primary}
				emptyscale=,#${palette.base}
				fullscale=,#${palette.primary}
				helpline=#${palette.subtext0},#${palette.base}
				roottext=#${palette.text},#${palette.base}
			'';

			# NEWT_MONO = 1;
		};
	};
}
