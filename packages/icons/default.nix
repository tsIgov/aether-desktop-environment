{
	stdenv,
	lib,
	catppuccin-papirus-folders,

	recolor,
	color-scheme ? null
}:
let
	name = "aether-icons";
	pname = "aether-icons";
	version = "1.0";

	recolorOvrd = recolor.override {
		inherit color-scheme;
	};
in

stdenv.mkDerivation {
	inherit name pname version;

	src = (catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; }).overrideAttrs (oldAttrs: { dontFixup = true; });

	buildInputs = [ recolorOvrd ];

	buildPhase = ''
		${recolorOvrd}/bin/aether-recolor share/icons/Papirus $TMPDIR/output
	'';

	installPhase = ''
		mkdir -p $out/share/icons
		cp -r $TMPDIR/output $out/share/icons/aether-icons
	'';

	dontFixup = true;
}
