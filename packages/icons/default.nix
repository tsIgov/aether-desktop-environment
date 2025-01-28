{ 
	stdenv, 
	lib,
	catppuccin-papirus-folders,

	aetherLib, 
	recolor, 
	flavor ? "mocha", 
	accent ? "mauve" 
}:
let
	pname = "aether-icons";
in

lib.checkListOfEnum "${pname}: flavor" aetherLib.appearance.validFlavors [ flavor ]
lib.checkListOfEnum "${pname}: accent" aetherLib.appearance.validAccents [ accent ]

stdenv.mkDerivation {
	inherit pname;
	version = "1.0";

	src = (catppuccin-papirus-folders.override { inherit flavor accent; });

	buildInputs = [ recolor ];

	buildPhase = ''
		${recolor}/bin/aether-recolor share/icons/Papirus $TMPDIR/output
	'';

	installPhase = ''
		mkdir -p $out/share/icons
		cp -r $TMPDIR/output $out/share/icons/aether-icons
	'';
}