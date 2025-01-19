{ stdenv, lib, aetherLib, python3, bash, flavor ? "mocha", ... }:
let
	pname = "aether-recolor";
	python = (python3.withPackages (pp: [ pp.tqdm pp.pillow ]));
in

lib.checkListOfEnum "${pname}: flavor" aetherLib.flavors [ flavor ]

stdenv.mkDerivation {
	inherit pname;
	version = "1.0";

	srcs = [ 
		./src/basic_colormath.tar.gz
		./src/color_manager.tar.gz
		./src/entry
	];
	sourceRoot = ".";

	nativeBuildInputs = [ 
		python
	];

	buildPhase = ''
		echo -e '
			#!${bash}/bin/sh
			set -e

			SCRIPT=$(realpath -s "$0")
			SCRIPTPATH=$(dirname "$SCRIPT")

			cd $SCRIPTPATH/../lib
			${python}/bin/python3 recolor.py' > recolor.sh
	'';

	installPhase = ''
		mkdir -p $out/lib
		mkdir -p $out/bin

		cp -r basic_colormath $out/lib
		cp -r color_manager $out/lib
		cp entry/recolor.py $out/lib/recolor.py
		
		cp recolor.sh $out/bin/aether-recolor
		chmod +x $out/bin/aether-recolor
	'';

}