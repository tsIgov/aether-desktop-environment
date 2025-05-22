{
	home = { config, aether, ... }:
	let
		terminalAccent = aether.lib.appearance.getTerminalAccentColor { inherit config; };
	in
	{
		home.sessionVariables = {
			NEWT_COLORS=''
				root=white,black
				border=${terminalAccent},black
				window=white,black
				shadow=black,black
				title=white,black
				button=black,${terminalAccent}
				actbutton=black,${terminalAccent}
				compactbutton=white,black
				checkbox=white,black
				actcheckbox=terminalAc${terminalAccent}cent,black
				entry=white,black
				disentry=gray,lightgray
				label=white,black
				listbox=white,black
				actlistbox=${terminalAccent},black
				sellistbox=${terminalAccent},black
				actsellistbox=${terminalAccent},black
				textbox=black,lightgray
				acttextbox=black,${terminalAccent}
				emptyscale=,black
				fullscale=,${terminalAccent}
				helpline=white,black
				roottext=white,black
			'';
		};
	};

}
