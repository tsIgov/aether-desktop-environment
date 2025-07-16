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
	name = "aether-icons-${flavor}-${accent}";
	pname = "aether-icons";
	version = "1.0";
in

lib.checkListOfEnum "${pname}: flavor" aetherLib.appearance.validFlavors [ flavor ]
lib.checkListOfEnum "${pname}: accent" aetherLib.appearance.validAccents [ accent ]

stdenv.mkDerivation {
	inherit name pname version;


	src = (catppuccin-papirus-folders.override { inherit flavor accent; }).overrideAttrs (oldAttrs: { dontFixup = true; });

	buildInputs = [ recolor ];

	buildPhase = ''
		${recolor}/bin/aether-recolor share/icons/Papirus $TMPDIR/output
	'';

	installPhase = ''
		mkdir -p $out/share/icons
		cp -r $TMPDIR/output $out/share/icons/aether-icons
	'';

	dontFixup = true;
}
