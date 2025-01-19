{ stdenv, makeWrapper, lib, aetherLib, python3, flavor ? "mocha", ... }:
let
	pname = "aether-recolor";
	python = (python3.withPackages (pp: [ pp.tqdm pp.pillow ]));

	createPlalette = import ./createPalette.nix aetherLib flavor;
in

lib.checkListOfEnum "${pname}: flavor" aetherLib.appearance.validFlavors [ flavor ]

stdenv.mkDerivation {
	inherit pname;
	version = "1.0";

	srcs = [ 
		./src/basic_colormath.tar.gz
		./src/color_manager.tar.gz
		./src/bin
	];
	sourceRoot = ".";

	nativeBuildInputs = [ 
		python
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