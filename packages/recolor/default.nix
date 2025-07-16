{ stdenv, makeWrapper, lib, aetherLib, python3, flavor ? "mocha", ... }:
let
	name = "aether-recolor-${flavor}";
	pname = "aether-recolor";
	version = "1.0";

	python = (python3.withPackages (pp: [ pp.tqdm pp.pillow ]));
	createPlalette = import ./createPalette.nix aetherLib flavor;
in

lib.checkListOfEnum "${pname}: flavor" aetherLib.appearance.validFlavors [ flavor ]

stdenv.mkDerivation {
	inherit name pname version;

	srcs = [
		./src/basic_colormath.tar.gz
		./src/color_manager.tar.gz
		./src/bin
	];
	sourceRoot = ".";

	buildInputs = [
		python
	];

	nativeBuildInputs = [
		makeWrapper
	];

	buildPhase = ''
		echo -e '${createPlalette}' > palette.json
	'';

	installPhase = ''
		mkdir -p $out/lib
		mkdir -p $out/bin

		cp -r basic_colormath $out/lib
		cp -r color_manager $out/lib
		cp palette.json $out/palette.json

		cp bin/aether-recolor.sh $out/bin/aether-recolor
		chmod +x $out/bin/aether-recolor
		wrapProgram $out/bin/aether-recolor \
			--prefix PATH : ${lib.makeBinPath [ python ]}
	'';
}
