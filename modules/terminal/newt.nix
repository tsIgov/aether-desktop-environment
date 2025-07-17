{
	home = { config, aether, ... }:
	let
		colorMap = {
			rosewater = "lightgray";
			flamingo = "white";
			pink = "brightmagenta";
			mauve = "magenta";
			red = "red";
			maroon = "brightred";
			peach = "brightyellow";
			yellow = "yellow";
			green = "green";
			teal = "brightgreen";
			sky = "cyan";
			sapphire = "brightcyan";
			blue = "blue";
			lavender = "brightblue";
		};

		accentName = config.aether.appearance.colors.primary;
		terminalAccent = colorMap.${accentName};
	in
	{
		home.sessionVariables = {
			NEWT_COLORS=''
				root=lightgray,black
				border=${terminalAccent},black
				window=lightgray,black
				shadow=black,black
				button=black,${terminalAccent}
				actbutton=black,${terminalAccent}
				compactbutton=lightgray,black
				checkbox=lightgray,black
				actcheckbox=${terminalAccent},black
				entry=lightgray,black
				disentry=gray,lightgray
				label=lightgray,black
				listbox=lightgray,black
				actlistbox=${terminalAccent},black
				sellistbox=${terminalAccent},black
				actsellistbox=${terminalAccent},black
				textbox=black,lightgray
				acttextbox=black,${terminalAccent}
				emptyscale=,black
				fullscale=,${terminalAccent}
				helpline=lightgray,black
				roottext=lightgray,black
			'';

			# NEWT_MONO = 1;
		};
	};

}
