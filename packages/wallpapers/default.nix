{
	stdenv,
	inkscape,

	aetherLib,
	flavor ? "mocha",
	accent ? "mauve"
}:
let
	name = "aether-wallpapers-${flavor}-${accent}";
	pname = "aether-wallpapers";
	version = "1.0";

	foreground-color = aetherLib.appearance.flavors.${flavor}.${accent};
	background-color = aetherLib.appearance.flavors.${flavor}.base;
in

stdenv.mkDerivation {
	inherit name pname version;

	srcs = [ ./images ];
	sourceRoot = ".";
	buildInputs = [ inkscape ];

	phases = [ "unpackPhase" "buildPhase" "installPhase" ];

	buildPhase = ''
		mkdir -p $TMPDIR/processed
		for svg in $(find ./images -name "*.svg"); do
			name=$(basename "$svg" .svg)
			echo $svg
			sed -e 's/#ffffff/#${foreground-color}/g' -e 's/#000000/#${background-color}/g' "$svg" > "$TMPDIR/processed/$name.processed.svg"

		done

		mkdir -p $TMPDIR/pngs
		for svg in $TMPDIR/processed/*.svg; do
			name=$(basename "$svg" .processed.svg)
			${inkscape}/bin/inkscape "$svg" --export-type=png --export-height=2048 --export-width=3640 --export-area-page --export-filename="$TMPDIR/pngs/$name.png"
		done
	'';

	installPhase = ''
		mkdir -p $out
		cp $TMPDIR/pngs/*.png $out/
	'';
}
