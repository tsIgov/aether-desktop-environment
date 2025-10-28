{ lib, stdenv, gum, iputils, util-linux, parted, cryptsetup, makeWrapper, ... }:

stdenv.mkDerivation {
	name = "aether-install";
	pname = "aether-install";
	version = "1.0";

	srcs = [
		./src/bin
		./src/lib
	];
	sourceRoot = ".";

	installPhase = ''
		mkdir -p $out/bin

		cp -r bin/aether-install.sh $out/bin/aether-install
		cp -r lib $out/lib

		chmod +x $out/bin/aether-install
		chmod +x $out/lib/*.sh

		wrapProgram $out/bin/aether-install \
			--prefix PATH : ${lib.makeBinPath [ gum iputils util-linux parted cryptsetup ]}
	'';

	buildInputs = [
		gum
		iputils # ping
		util-linux # cfdisk
		parted
		cryptsetup
	];

	nativeBuildInputs = [
		makeWrapper
	];

}
